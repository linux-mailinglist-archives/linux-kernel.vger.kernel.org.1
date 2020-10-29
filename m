Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A889129F05A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgJ2PpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:45:18 -0400
Received: from foss.arm.com ([217.140.110.172]:39656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgJ2PpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:45:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C77B331B;
        Thu, 29 Oct 2020 08:45:16 -0700 (PDT)
Received: from [10.57.18.142] (unknown [10.57.18.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DEAF3F66E;
        Thu, 29 Oct 2020 08:45:15 -0700 (PDT)
Subject: Re: [PATCH v3 00/26] coresight: Support for ETM system instructions
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <CAJ9a7Vh5ODr=atPLffG0ud2XZjwav5ysiR9J2rQQxWfmL6ypQA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2be2385a-cc9d-4585-6c2c-dde833d735fe@arm.com>
Date:   Thu, 29 Oct 2020 15:45:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJ9a7Vh5ODr=atPLffG0ud2XZjwav5ysiR9J2rQQxWfmL6ypQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/20 7:53 AM, Mike Leach wrote:
> Hi Suzuki,
> 
> On Wed, 28 Oct 2020 at 22:10, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> CoreSight ETMv4.4 obsoletes memory mapped access to ETM and
>> mandates the system instructions for registers.
>> This also implies that they may not be on the amba bus.
>> Right now all the CoreSight components are accessed via memory
>> map. Also, we have some common routines in coresight generic
>> code driver (e.g, CS_LOCK, claim/disclaim), which assume the
>> mmio. In order to preserve the generic algorithms at a single
>> place and to allow dynamic switch for ETMs, this series introduces
>> an abstraction layer for accessing a coresight device. It is
>> designed such that the mmio access are fast tracked (i.e, without
>> an indirect function call).
>>
>> This will also help us to get rid of the driver+attribute specific
>> sysfs show/store routines and replace them with a single routine
>> to access a given register offset (which can be embedded in the
>> dev_ext_attribute). This is not currently implemented in the series,
>> but can be achieved.
>>
>> Further we switch the generic routines to work with the abstraction.
>> With this in place, we refactor the etm4x code a bit to allow for
>> supporting the system instructions with very little new code. The
>> changes also switch to using the system instructions by default
>> even when we may have an MMIO.
>>
>> We use TRCDEVARCH for the detection of the ETM component, which
>> is a standard register as per CoreSight architecture, rather than
>> the etm specific id register TRCIDR1. This is for making sure
>> that we are able to detect the ETM via system instructions accurately,
>> when the the trace unit could be anything (etm or a custom trace unit).
>> To keep the backward compatibility for any existing broken impelementation
>> which may not implement TRCDEVARCH, we fall back to TRCIDR1. Also
>> this covers us for the changes in the future architecture [0].
>>
>> The series has been mildly tested on a model for system instructions.
>> I would really appreciate any testing on real hardware.
>>
>> Applies on coresight/next.
>>
>> [0] https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers/trcidr1
>>
>> Known issues:
>>    Checkpatch failure for "coresight: etm4x: Add sysreg access helpers" :
>>
>>    ERROR: Macros with complex values should be enclosed in parentheses
>>    #121: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:153:
>>    +#define CASE_READ(res, x)                                      \
>>    +       case (x): { (res) = read_etm4x_sysreg_const_offset((x)); break; }
>>
>>
>> I don't know how to fix that without breaking the build ! Suggestions
>> welcome.
>>
> 
> I hit exactly the same issue with my recent v2 set. The checker really
> hates case statements in macros. In my case I shut it up for v3 by
> changing:-
> 
>      #define MAPREG(cval, elem) \
>          case cval: \
>              reg->drv_store = &drvcfg->elem; \
>              break;
> 
> 
>      if (((offset >= TRCEVENTCTL0R) && (offset <= TRCVIPCSSCTLR)) ||
>          ((offset >= TRCSEQRSTEVR) && (offset <= TRCEXTINSELR)) ||
>          ((offset >= TRCCIDCCTLR0) && (offset <= TRCVMIDCCTLR1))) {
>          switch (offset) {
>              /* 32 bit single control and filter registers */
>              MAPREG(TRCEVENTCTL0R, eventctrl0);
>              MAPREG(TRCEVENTCTL1R, eventctrl1);
>              MAPREG(TRCSTALLCTLR, stall_ctrl);
>              MAPREG(TRCTSCTLR, ts_ctrl);
>              MAPREG(TRCSYNCPR, syncfreq);
>              MAPREG(TRCCCCTLR, ccctlr);
>              MAPREG(TRCBBCTLR, bb_ctrl);
>              MAPREG(TRCVICTLR, vinst_ctrl);
>              MAPREG(TRCVIIECTLR, viiectlr);
>              MAPREG(TRCVISSCTLR, vissctlr);
>              MAPREG(TRCVIPCSSCTLR, vipcssctlr);
>              MAPREG(TRCSEQRSTEVR, seq_rst);
>              MAPREG(TRCSEQSTR, seq_state);
>              MAPREG(TRCEXTINSELR, ext_inp);
>              MAPREG(TRCCIDCCTLR0, ctxid_mask0);
>              MAPREG(TRCCIDCCTLR1, ctxid_mask1);
>              MAPREG(TRCVMIDCCTLR0, vmid_mask0);
>              MAPREG(TRCVMIDCCTLR1, vmid_mask1);
>          default:
>              err = -EINVAL;
>              break;
>          }
> 
> 
> to
> 
> err = -EINVAL;
> 
> #define CHECKREG(cval, elem) \
>      { \
>          if (offset == cval) { \
>              reg->drv_store = &drvcfg->elem; \
>              err = 0; \
>              break; \
>          } \
>      }
> 
>      if (((offset >= TRCEVENTCTL0R) && (offset <= TRCVIPCSSCTLR)) ||
>          ((offset >= TRCSEQRSTEVR) && (offset <= TRCEXTINSELR)) ||
>          ((offset >= TRCCIDCCTLR0) && (offset <= TRCVMIDCCTLR1))) {
>          do {
>              CHECKREG(TRCEVENTCTL0R, eventctrl0);
>              CHECKREG(TRCEVENTCTL1R, eventctrl1);
>              CHECKREG(TRCSTALLCTLR, stall_ctrl);
>              CHECKREG(TRCTSCTLR, ts_ctrl);
>              CHECKREG(TRCSYNCPR, syncfreq);
>              CHECKREG(TRCCCCTLR, ccctlr);
>              CHECKREG(TRCBBCTLR, bb_ctrl);
>              CHECKREG(TRCVICTLR, vinst_ctrl);
>              CHECKREG(TRCVIIECTLR, viiectlr);
>              CHECKREG(TRCVISSCTLR, vissctlr);
>              CHECKREG(TRCVIPCSSCTLR, vipcssctlr);
>              CHECKREG(TRCSEQRSTEVR, seq_rst);
>              CHECKREG(TRCSEQSTR, seq_state);
>              CHECKREG(TRCEXTINSELR, ext_inp);
>              CHECKREG(TRCCIDCCTLR0, ctxid_mask0);
>              CHECKREG(TRCCIDCCTLR1, ctxid_mask1);
>              CHECKREG(TRCVMIDCCTLR0, vmid_mask0);
>              CHECKREG(TRCVMIDCCTLR1, vmid_mask1);
>          } while (0);
> 
> 
> A bit contrived but functionally the same - and doesn't annoy the
> checker, No idea if the code is more or less efficient after
> compilation than a standard switch / case combo, but not on a critical
> path for me so wasn't bothered.

Thanks Mike. Functionally it is fine. But I think the Compiler wil be 
able to optimize it better with switch() for a large list of cases
with consecutive values.

I guess there are more and more places that this is useful.
I have Cc'ed the checkpatch maintainers in the patch in question.

Cheers
Suzuki
