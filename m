Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D181C280990
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgJAVm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:42:59 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:24239 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAVm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1601588580;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=z6b/r3hHL+5K5thUZG5Lk9eZ7y9ACsF0mo+j/bOxxXw=;
  b=LLhPXUuWnV5TOiz0ml5LGS/YuvZmnUuXHdQN6q02mxGeprJbdJsA3ntI
   m5kbK38d5ktDwfsJ75Gl3Jc+NUCSInolJssa9OBhuAiAs4/NOiW4sJG5w
   p4Zd3PqIpVi2DxhN8CMNrWaFqHmpgDE0Jxj6WKg1HnVndDmSlx72nH2Lz
   s=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: IVgPxBubx9IFKOZVlPysbMtnRXL4ZpfFLZGy8JIIMu4gYAF5uHeGUVV/6cv17L3FtuE6Lzfdn+
 3IOUzTTBxxICGU2Lydv8XL0UBulK0Jidy7qr28PB/wuCrRR8ewCWD+6taLi60v/SlHgxVAjfVS
 Lwn3g2oYkxiqqIlDy2klQRgXBV7BUy4hcK6cRc78LAswrVh3hRxCsulsUVDUMCvNbVFQE35Co7
 RMwrOyrsCOmTHj5k6EFGrQ2Xyf+QoS4DnJgd3EsqcfYgFB4Uiqe9aYk/qMQfRJNn5UsGjDD9LO
 sEc=
X-SBRS: None
X-MesageID: 28456287
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,325,1596513600"; 
   d="scan'208";a="28456287"
Subject: Re: How should we handle illegal task FPU state?
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>
References: <CALCETrXENKF9iVXaQrQcbgFq7fksC2pGz86tr9YGgDdeP3uR-Q@mail.gmail.com>
 <71682bce-a925-d3bd-18ef-d2e4eb8ebc8e@intel.com>
 <20201001205857.GH7474@linux.intel.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <93999eea-468c-c4a7-d793-b6c82e4b26a4@citrix.com>
Date:   Thu, 1 Oct 2020 22:42:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001205857.GH7474@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 FTLPEX02CL05.citrite.net (10.13.108.178)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2020 21:58, Sean Christopherson wrote:
> On Thu, Oct 01, 2020 at 01:32:04PM -0700, Yu, Yu-cheng wrote:
>> On 10/1/2020 10:43 AM, Andy Lutomirski wrote:
>>> The question is: what do we do about it?  We have two basic choices, I think.
>>>
>>> a) Decide that the saved FPU for a task *must* be valid at all times.
>>> If there's a failure to restore state, kill the task.
>>>
>>> b) Improve our failed restoration handling and maybe even
>>> intentionally make it possible to create illegal state to allow
>>> testing.
>>>
>>> (a) sounds like a nice concept, but I'm not convinced it's practical.
>>> For example, I'm not even convinced that the set of valid SSP values
>>> is documented.
> Eh, crappy SDM writing isn't a good reason to make our lives harder.  The
> SSP MSRs are canonical MSRs and follow the same rules as the SYSCALL,
> FS/GS BASE, etc... MSRs.  I'll file an SDM bug.

Don't forget the added constraint of being 4 byte aligned. ;)

But the SDM is fine in this regard, at least as far as Vol4 goes, even
if does have an excessively verbose way of expressing itself.

~Andrew
