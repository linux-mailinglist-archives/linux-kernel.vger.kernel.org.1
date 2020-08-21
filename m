Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72AB24CD70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 07:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgHUFxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 01:53:41 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:10457 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbgHUFxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:53:40 -0400
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
CC:     =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Nick Kralevich <nnk@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
References: <20200817170729.2605279-1-tweek@google.com>
 <20200817170729.2605279-4-tweek@google.com>
 <d8b1d7a2-2b8e-c714-77b6-d4e7f3fedf08@gmail.com>
 <6730ec4a-d11b-5c05-b64f-380104a86dab@sony.com>
 <CAEjxPJ7k648nQxCDzcHc0h1vEfNhAJShG5iKmD52nuO5s9phsQ@mail.gmail.com>
 <CAHC9VhSYJUAacvzp1hR4RMChTctJ2sFb5+oy_wbsigaWMGTYHg@mail.gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <991d6a06-4b89-989a-92d1-82f295efe9bf@sony.com>
Date:   Fri, 21 Aug 2020 07:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSYJUAacvzp1hR4RMChTctJ2sFb5+oy_wbsigaWMGTYHg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=pGLkceISAAAA:8 a=z6gsHLkEAAAA:8 a=zqV3RlLadK9Wwbd0qEsA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/20 4:22 AM, Paul Moore wrote:
> On Tue, Aug 18, 2020 at 8:14 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Tue, Aug 18, 2020 at 4:11 AM peter enderborg <peter.enderborg@sony.com> wrote:
> ...
>
>>> Is there any other things we need to fix? A part 1&2 now OK?
>> They looked ok to me, but Paul should review them.
> Patches 1 and 2 look fine to me with the small nits that Stephen
> pointed out corrected.  I'm glad to see the information in string form
> now, I think that will be a big help for people making use of this.
>
> Unfortunately, I'm a little concerned about patch 3 for the reason
> Stephen already mentioned.  While changes to the class mapping are
> infrequent, they do happen, and I'm not very excited about adding it
> to the userspace kAPI via a header.  Considering that the tracing
> tools are going to be running on the same system that is being
> inspected, perhaps the tracing tools could inspect
> /sys/fs/selinux/class at runtime to query the permission mappings?
> Stephen, is there a libselinux API which does this already?
>
One way to use this trace is to write directly to a memory buffer over a time
period. In the case for Android and I guess in many other embedded cases too
they are moved to be some other machine to be analysed so having them
locked to where it was running also have problems.

So what is the problem we see with the plugin, that we have perms names
that are "unknown" ?

