Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF892DD844
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 19:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgLQS1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 13:27:04 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:44561 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgLQS1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 13:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1608229623;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0JnxpV5kSnzrC5FbbL8YNG1KAvQnfLMRnXpPN2OIrj0=;
  b=MS3qYUNMQpDO8xkDeo3i1YyqqQwGGm3BY/7rUGBqTxZ18mhFqO4d1DtD
   EaQEQ+MqC9R25/4B8rqbA/Jc7cENKYQvyisHEvhEQLd4CORqTPTwYfnAj
   dn61t+5LkkSl7salj3absNdhLCA8lvLqq332FtDFYSxf6MgfDRvWgm1E2
   Y=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: 00tXMVKz+bqsvoJATU8UhkG0eBARLmv5IpviZufx/bZc56Toigz1exXkaq/60al/HMtc0VNN9g
 k1QKMN0UehcqDT62F4WnbUjWK+u/kwbUPTkrS1h/l3YEhMC+8o7G9iRsiXIsYI9DydJJGpDWyd
 QSC5FwiSno+b9sn3UcJbmC9EQ1kdZMvZmZZJh+jJ/YWqaqU9+gLhru6eCHDx8A6/NMalhCeFkQ
 CwWXMpJnNZqRs2epeeF571ULEE5+T1kMsOrBOWiF3YoWDij5uJKUfkJ71GQKwF5sOV5fwk9E13
 3Zs=
X-SBRS: 5.2
X-MesageID: 33507226
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.78,428,1599537600"; 
   d="scan'208";a="33507226"
Subject: Re: [PATCH v2] xen/xenbus: make xs_talkv() interruptible
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20201215111055.3810-1-jgross@suse.com>
 <2deac9ce-0c27-a472-7d51-b91a640d92ed@citrix.com>
 <8d26b752-b7ba-159f-5bed-bb015a06d819@suse.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <2414c191-ff55-e446-b555-c9d0ccca6b93@citrix.com>
Date:   Thu, 17 Dec 2020 18:25:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8d26b752-b7ba-159f-5bed-bb015a06d819@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL03.citrite.net (10.13.108.165)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2020 08:21, Jürgen Groß wrote:
> On 15.12.20 21:59, Andrew Cooper wrote:
>> On 15/12/2020 11:10, Juergen Gross wrote:
>>> In case a process waits for any Xenstore action in the xenbus driver
>>> it should be interruptible by signals.
>>>
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> ---
>>> V2:
>>> - don't special case SIGKILL as libxenstore is handling -EINTR fine
>>> ---
>>>   drivers/xen/xenbus/xenbus_xs.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/xen/xenbus/xenbus_xs.c
>>> b/drivers/xen/xenbus/xenbus_xs.c
>>> index 3a06eb699f33..17c8f8a155fd 100644
>>> --- a/drivers/xen/xenbus/xenbus_xs.c
>>> +++ b/drivers/xen/xenbus/xenbus_xs.c
>>> @@ -205,8 +205,15 @@ static bool test_reply(struct xb_req_data *req)
>>>     static void *read_reply(struct xb_req_data *req)
>>>   {
>>> +    int ret;
>>> +
>>>       do {
>>> -        wait_event(req->wq, test_reply(req));
>>> +        ret = wait_event_interruptible(req->wq, test_reply(req));
>>> +
>>> +        if (ret == -ERESTARTSYS && signal_pending(current)) {
>>> +            req->msg.type = XS_ERROR;
>>> +            return ERR_PTR(-EINTR);
>>> +        }
>>
>> So now I can talk fully about the situations which lead to this, I think
>> there is a bit more complexity.
>>
>> It turns out there are a number of issues related to running a Xen
>> system with no xenstored.
>>
>> 1) If a xenstore-write occurs during startup before init-xenstore-domain
>> runs, the former blocks on /dev/xen/xenbus waiting for xenstored to
>> reply, while the latter blocks on /dev/xen/xenbus_backend when trying to
>> tell the dom0 kernel that xenstored is in dom1.  This effectively
>> deadlocks the system.
>
> This should be easy to solve: any request to /dev/xen/xenbus should
> block upfront in case xenstored isn't up yet (could e.g. wait
> interruptible until xenstored_ready is non-zero).

I'm not sure that that would fix the problem.  The problem is that
setting the ring details via /dev/xen/xenbus_backend blocks, which
prevents us launching the xenstored stubdomain, which prevents the
earlier xenbus write being completed.

So long as /dev/xen/xenbus_backend doesn't block, there's no problem
with other /dev/xen/xenbus activity being pending briefly.


Looking at the current logic, I'm not completely convinced.  Even
finding a filled-in evtchn/gfn doesn't mean that xenstored is actually
ready.

There are 3 possible cases.

1) PV guest, and details in start_info
2) HVM guest, and details in HVM_PARAMs
3) No details (expected for dom0).  Something in userspace must provide
details at a later point.

So the setup phases go from nothing, to having ring details, to finding
the ring working.

I think it would be prudent to try reading a key between having details
and declaring the xenstored_ready.  Any activity, even XS_ERROR,
indicates that the other end of the ring is listening.

>
>> 2) If xenstore-watch is running when xenstored dies, it spins at 100%
>> cpu usage making no system calls at all.  This is caused by bad error
>> handling from xs_watch(), and attempting to debug found:
>
> Can you expand on "bad error handling from xs_watch()", please?

do_watch() has

    for ( ... ) { // defaults to an infinite loop
        vec = xs_read_watch();
        if (vec == NULL)
            continue;
        ...
    }


My next plan was to experiment with break instead of continue, which
I'll get to at some point.

>
>>
>> 3) (this issue).  If anyone starts xenstore-watch with no xenstored
>> running at all, it blocks in D in the kernel.
>
> Should be handled with solution for 1).
>
>>
>> The cause is the special handling for watch/unwatch commands which,
>> instead of just queuing up the data for xenstore, explicitly waits for
>> an OK for registering the watch.  This causes a write() system call to
>> block waiting for a non-existent entity to reply.
>>
>> So while this patch does resolve the major usability issue I found (I
>> can't even SIGINT and get my terminal back), I think there are issues.
>>
>> The reason why XS_WATCH/XS_UNWATCH are special cased is because they do
>> require special handling.  The main kernel thread for processing
>> incoming data from xenstored does need to know how to associate each
>> async XS_WATCH_EVENT to the caller who watched the path.
>>
>> Therefore, depending on when this cancellation hits, we might be in any
>> of the following states:
>>
>> 1) the watch is queued in the kernel, but not even sent to xenstored yet
>> 2) the watch is queued in the xenstored ring, but not acted upon
>> 3) the watch is queued in the xenstored ring, and the xenstored has seen
>> it but not replied yet
>> 4) the watch has been processed, but the XS_WATCH reply hasn't been
>> received yet
>> 5) the watch has been processed, and the XS_WATCH reply received
>>
>> State 5 (and a little bit) is the normal success path when xenstored has
>> acted upon the request, and the internal kernel infrastructure is set up
>> appropriately to handle XS_WATCH_EVENTs.
>>
>> States 1 and 2 can be very common if there is no xenstored (or at least,
>> it hasn't started up yet).  In reality, there is either no xenstored, or
>> it is up and running (and for a period of time during system startup,
>> these cases occur in sequence).
>
> Yes. this is the reason we can't just reject a user request if xenstored
> hasn't been detected yet: it could be just starting.

Right, and I'm not suggesting that we'd want to reject accesses while
xenstored is starting up.

>
>>
>> As soon as the XS_WATCH event has been written into the xenstored ring,
>> it is not safe to cancel.  You've committed to xenstored processing the
>> request (if it is up).
>
> I'm not sure this is true. Cancelling it might result in a stale watch
> in xenstored, but there shouldn't be a problem related to that. In case
> that watch fires the event will normally be discarded by the kernel as
> no matching watch is found in the kernel's data. In case a new watch
> has been setup with the same struct xenbus_watch address (which is used
> as the token), then this new watch might fire without the node of the
> new watch having changed, but spurious watch events are defined to be
> okay (OTOH the path in the event might look strange to the handler).

Watches are a quota'd resource in (at least some) xenstored
configurations.  Losing track of the registration is a resource leak,
even if the kernel can filter and discard the unexpected watch events.

>> If xenstored is actually up and running, its fine and necessary to
>> block.  The request will be processed in due course (timing subject to
>> the client and server load).  If xenstored isn't up, blocking isn't ok.
>>
>> Therefore, I think we need to distinguish "not yet on the ring" from "on
>> the ring", as our distinction as to whether cancelling is safe, and
>> ensure we don't queue anything on the ring before we're sure xenstored
>> has started up.
>>
>> Does this make sense?
>
> Basically, yes.

Great.  If I get any time, I'll try to look into some fixes along the
above lines.

~Andrew
