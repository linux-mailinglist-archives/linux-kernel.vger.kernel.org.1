Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FE02EF412
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbhAHOkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbhAHOkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:40:08 -0500
Received: from cc-smtpout2.netcologne.de (cc-smtpout2.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A40C061381
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 06:39:28 -0800 (PST)
Received: from cc-smtpin3.netcologne.de (cc-smtpin3.netcologne.de [89.1.8.203])
        by cc-smtpout2.netcologne.de (Postfix) with ESMTP id 319B0126B8;
        Fri,  8 Jan 2021 15:39:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by cc-smtpin3.netcologne.de (Postfix) with ESMTP id 2E49911E68;
        Fri,  8 Jan 2021 15:39:26 +0100 (CET)
Received: from [213.196.221.66] (helo=cc-smtpin3.netcologne.de)
        by localhost with ESMTP (eXpurgate 4.11.6)
        (envelope-from <kurt@garloff.de>)
        id 5ff86e9e-0799-7f0000012729-7f000001abc8-1
        for <multiple-recipients>; Fri, 08 Jan 2021 15:39:26 +0100
Received: from nas2.garloff.de (xdsl-213-196-221-66.nc.de [213.196.221.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin3.netcologne.de (Postfix) with ESMTPSA;
        Fri,  8 Jan 2021 15:39:22 +0100 (CET)
Received: from [192.168.155.202] (ap4.garloff.de [192.168.155.15])
        by nas2.garloff.de (Postfix) with ESMTPSA id 289B9B3B13A5;
        Fri,  8 Jan 2021 15:39:21 +0100 (CET)
Subject: Re: NFS 4.2 client support broken on 5.10.5
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "NeilB@suse.de" <NeilB@suse.de>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ee320885-9a78-80b8-9341-7c631df60d3a@garloff.de>
 <2f401e0a738b7acb926bd2375012e6384a2cd9b6.camel@hammerspace.com>
From:   Kurt Garloff <kurt@garloff.de>
Message-ID: <927fcf61-7992-1b9f-ae39-c71d96323fbc@garloff.de>
Date:   Fri, 8 Jan 2021 15:39:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2f401e0a738b7acb926bd2375012e6384a2cd9b6.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

On 08/01/2021 12:58, Trond Myklebust wrote:
> On Fri, 2021-01-08 at 12:41 +0100, Kurt Garloff wrote:
>> Hi Neil, Anna, Trond,
>>
>> compiling a kernel, I suddenly started getting errors from objtool
>> orc.
>> (This first occurs on init/main.o.)
>>
>> I looked at all kind of things, before I noticed that this was not a
>> toolchain issue (gcc-10.2.1 self compiled), gcc plugins (I use
>> structleak and stackleak) nor an issue with objtool or libelf,
>> but that there was an -EIO error.
>>
>> The kernel tree is on an NFS share, and I run 5.10.5 client kernel
>> against the kernel NFS (4.2) server, running a 5.10.3 kernel.
>>
>> The issue does NOT occur on a 5.10.3 client kernel, but is easily
>> reproducible on 5.10.5. Note that 5.10.5 on a local file system or
>> against an NFSv3 server does not show the issue.
>>
>> Test program that reproduces this on the first pwrite64() is
>> attached.
>> Note that the call to ftruncate() is required to make the problem
>> happen.
>>
>> I could go on bisecting this to a particular patch, but you'll
>> probably be able to see right away what's wrong.
>>
> Hmm... If this is NFSv4.2 do you have READ_PLUS turned on or off in
> .config? It really is not safe to enable READ_PLUS on 5.10 kernels
> since that can cause random memory corruption.
OK, it is turned on in my kernel -- looks like I have not read the
warning in the config option help text carefully enough ...

I'll test what happens if I switch it off and report back.

Thanks for the quick response

---

Kurt Garloff <kurt@garloff.de>
Cologne, Germany


