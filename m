Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7EA28F570
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389354AbgJOPCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:02:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:38298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388810AbgJOPCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:02:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602774142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOAorilrTXfeOIZQ8lkczi+c0MEjjEKFoJ24vlzPups=;
        b=GUhP8sHjWJlLvc81IjV2qAGyp9DPLy2UZxvgQrm4q9TjosVlEgw5GsrwMe+FKzcnMzexg/
        rrpix3Sv2u38vnE0/MQBIunUXc2JdRjV2qrE0Hlt+4wL/k8g2+7Rju4hfLCoOX29S/V/TX
        bNPmYaPvD8NARY29yRsCwl2nEjfKae0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8625AF87;
        Thu, 15 Oct 2020 15:02:21 +0000 (UTC)
Subject: Re: [PATCH 1/2] xen: Remove Xen PVH/PVHVM dependency on PCI
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201014175342.152712-1-jandryuk@gmail.com>
 <20201014175342.152712-2-jandryuk@gmail.com>
 <b74a3f83-cd8a-34a3-b436-95141f01cb20@suse.com>
 <CAKf6xps+mAFdfk8uBw=aMsAFNYmt4ETPkB8dwT3sTv-qPbVENw@mail.gmail.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <3919ef15-379b-cc1e-994c-c33b23865afd@suse.com>
Date:   Thu, 15 Oct 2020 17:02:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAKf6xps+mAFdfk8uBw=aMsAFNYmt4ETPkB8dwT3sTv-qPbVENw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.2020 16:59, Jason Andryuk wrote:
> On Thu, Oct 15, 2020 at 4:10 AM Jan Beulich <jbeulich@suse.com> wrote:
>>
>> On 14.10.2020 19:53, Jason Andryuk wrote:
>>> @@ -76,7 +80,9 @@ config XEN_DEBUG_FS
>>>         Enabling this option may incur a significant performance overhead.
>>>
>>>  config XEN_PVH
>>> -     bool "Support for running as a Xen PVH guest"
>>> +     bool "Xen PVH guest support"
>>
>> Tangential question: Is "guest" here still appropriate, i.e.
>> isn't this option also controlling whether the kernel can be
>> used in a PVH Dom0?
> 
> Would you like something more generic like "Xen PVH support" and
> "Support for running in Xen PVH mode"?

Yeah, just dropping "guest" would be fine with me. No idea how
to reflect that PVH Dom0 isn't supported, yet.

Jan
