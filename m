Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D771B5706
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 10:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDWIRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 04:17:11 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:48578 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbgDWIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:17:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587629830; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=NMXGFFpZfb9Xhg9uciZUMKKswWRFPn2XrtWUl2kVbYo=;
 b=CdjgUn1vn7RAJNAs4oIdraG8up0NWvcmnpg9BxMj8DDzJ2GFXvdMe9PrGVaE+g7Po8D22QJ7
 ohWuWedYAYLC3D9CjGCT89pXqfbhcjrIZsH0b6K5w7gi+80mMMpvX2ciHmtrNLfYZKJM07SL
 NfcBWisD/4NgUDiEn/fUYcQQZfo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea14f02.7f2ab72f3fb8-smtp-out-n05;
 Thu, 23 Apr 2020 08:17:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5FB8C43636; Thu, 23 Apr 2020 08:17:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A186C433D2;
        Thu, 23 Apr 2020 08:17:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 23 Apr 2020 13:47:03 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS , Joerg Roedel <joro@8bytes.org>," 
        <iommu@lists.linux-foundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
In-Reply-To: <CAD=FV=VBM6cS1UmWTUJ2vrt0a2zn7xV3C53tpthBx58M2=1JPg@mail.gmail.com>
References: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
 <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com>
 <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
 <5858bdac-b7f9-ac26-0c0d-c9653cef841d@arm.com>
 <d60196b548e1241b8334fadd0e8c2fb5@codeaurora.org>
 <CAD=FV=WXTN6xxqtL6d6MHxG8Epuo6FSQERRPfnoSCskhjh1KeQ@mail.gmail.com>
 <890456524e2df548ba5d44752513a62c@codeaurora.org>
 <20200331074400.GB25612@willie-the-truck>
 <1bf04938249bcd5b2111c1921facfd25@codeaurora.org>
 <CAD=FV=VBM6cS1UmWTUJ2vrt0a2zn7xV3C53tpthBx58M2=1JPg@mail.gmail.com>
Message-ID: <6c82e688f335b9c07b0f52987244664b@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-04-23 01:19, Doug Anderson wrote:
> Hi,
> 
> On Tue, Mar 31, 2020 at 12:53 AM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> 
>> Hi Will,
>> 
>> On 2020-03-31 13:14, Will Deacon wrote:
>> > On Tue, Mar 31, 2020 at 01:06:11PM +0530, Sai Prakash Ranjan wrote:
>> >> On 2020-03-30 23:54, Doug Anderson wrote:
>> >> > On Sat, Mar 28, 2020 at 12:35 AM Sai Prakash Ranjan
>> >> > <saiprakash.ranjan@codeaurora.org> wrote:
>> >> > >
>> >> > > > Of course the fact that in practice we'll *always* see the warning
>> >> > > > because there's no way to tear down the default DMA domains, and even
>> >> > > > if all devices *have* been nicely quiesced there's no way to tell, is
>> >> > > > certainly less than ideal. Like I say, it's not entirely clear-cut
>> >> > > > either way...
>> >> > > >
>> >> > >
>> >> > > Thanks for these examples, good to know these scenarios in case we
>> >> > > come
>> >> > > across these.
>> >> > > However, if we see these error/warning messages appear everytime then
>> >> > > what will be
>> >> > > the credibility of these messages? We will just ignore these messages
>> >> > > when
>> >> > > these issues you mention actually appears because we see them
>> >> > > everytime
>> >> > > on
>> >> > > reboot or shutdown.
>> >> >
>> >> > I would agree that if these messages are expected to be seen every
>> >> > time, there's no way to fix them, and they're not indicative of any
>> >> > problem then something should be done.  Seeing something printed at
>> >> > "dev_error" level with an exclamation point (!) at the end makes me
>> >> > feel like this is something that needs immediate action on my part.
>> >> >
>> >> > If we really can't do better but feel that the messages need to be
>> >> > there, at least make them dev_info and less scary like:
>> >> >
>> >> >   arm-smmu 15000000.iommu: turning off; DMA should be quiesced before
>> >> > now
>> >> >
>> >> > ...that would still give you a hint in the logs that if you saw a DMA
>> >> > transaction after the message that it was a bug but also wouldn't
>> >> > sound scary to someone who wasn't seeing any other problems.
>> >> >
>> >>
>> >> We can do this if Robin is OK?
>> >
>> > It would be nice if you could figure out which domains are still live
>> > when
>> > the SMMU is being shut down in your case and verify that it *is* infact
>> > benign before we start making the message more friendly. As Robin said
>> > earlier, rogue DMA is a real nightmare to debug.
>> >
>> 
>> I could see this error message for all the clients of apps_smmu.
>> I checked manually enabling bypass and removing iommus dt property
>> for each client of apps_smmu.
> 
> Any update on the status here?  If I'm reading the conversation above,
> Robin said: "we'll *always* see the warning because there's no way to
> tear down the default DMA domains, and even if all devices *have* been
> nicely quiesced there's no way to tell".  Did I understand that
> properly?  If so, it seems like it's fully expected to see this
> message on every reboot and it doesn't necessarily signify anything
> bad.
> 

Understanding is the same, waiting for Will and Robin to check if its OK
to make the message more friendly.

-Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
