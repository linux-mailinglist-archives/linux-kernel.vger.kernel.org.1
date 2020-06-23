Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7CC204697
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 03:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbgFWBRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 21:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731466AbgFWBRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:17:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E157C061573;
        Mon, 22 Jun 2020 18:17:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id k18so8282916qke.4;
        Mon, 22 Jun 2020 18:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gC57BjwKcucnLMsUW+vAn+PwIgiZSIGcPyfyFmHu+os=;
        b=QKIHheKPV29zWtTngZT/ND4UW8xb/Umw4UYiWlvO5VeSy3jx+nQ83tJJI94SAeFV9s
         As50r1AM4wR2iqGSxwTjRMrKsCq4Xy1AR4F8Z0IWS4DgKPlHM/e6RgFADbDAhL2EOwtv
         tzG7zSPqbQRSr6DfsPws+NGFwYx2AflbFUqH4iee58CWqWNPQ21eJ1+JcjnQlR30Jv3C
         LKhSA4p36M3qz4d9XxP/6n/gvpsqTvXuNawAJDcJsn/5p/yh+oGxgmSbWByOS/hxC7MZ
         NTct4G9L0HJCT/HozB2qbDsaVR6blvfWIJweHaZp4zrwpxua1NuKBNYD5HQ4RT/ipw/Z
         BAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gC57BjwKcucnLMsUW+vAn+PwIgiZSIGcPyfyFmHu+os=;
        b=snuTRsXL4vsfNmGdYAzrlGee4CYivqF+7iGC6j5o80pgICc8/z179247c9Mx78RBEx
         IfOWT8T56+FCMH3zgmfH2HLCAsAVHKGdj+krD4yQAzP8ObweNoTICTNGv6TFrNzXWpUg
         FayfuIn7bVYVXt/hkY5DTKRzFK6HVQyqkpdlB0Oj0SVl0AYs2P/DqTscZ9tSWkOh6N1G
         lzJyyEWLuXs6CsmRW0gyGqUXN8ObihZNZWzXILbIYxJpv2NINRfCOJC1tjqpp0MVSYyf
         THyqUkM4yqWbMxYdkG/38rwY8lhZgZ3Ca1YoUtsGUDWteMvSFb0OhkFve+QigzOO/p2+
         nWwA==
X-Gm-Message-State: AOAM53120+8T/H8KmMHt/DGtOtf3xcbcGqcs8sydZmjn8T0nUQOfTstG
        /C4hh4XhP2KpgOFfuWui3uY=
X-Google-Smtp-Source: ABdhPJyE+/hqErBKZpevE+iIARChtj2p2s5SrAEwhbaeilTu1rM5YF5H/1ULZ7y0fkI4FS6LHS03Rg==
X-Received: by 2002:a37:4a49:: with SMTP id x70mr18224922qka.230.1592875039129;
        Mon, 22 Jun 2020 18:17:19 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id p29sm4870311qtu.15.2020.06.22.18.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 18:17:18 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
From:   Frank Rowand <frowand.list@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <4b188fb5-6667-720d-46e1-6f103efe8966@gmail.com>
 <20200615092644.GA2608702@dell>
 <eef50a78-8571-5600-4fee-c824fd4a7f69@gmail.com>
 <20200622085009.GP954398@dell>
 <cd8952da-cc55-8087-b9f6-876417beb188@gmail.com>
 <20200622151054.GW954398@dell>
 <037c0fd2-df35-5981-7ef2-c6199841650d@gmail.com>
 <20200622191133.GY954398@dell>
 <dc893ce4-8a4d-b7d9-8591-18a8b9b2ea2b@gmail.com>
Message-ID: <eae9cc00-e67a-cb6a-37c2-f2235782ed77@gmail.com>
Date:   Mon, 22 Jun 2020 20:17:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <dc893ce4-8a4d-b7d9-8591-18a8b9b2ea2b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22 17:23, Frank Rowand wrote:
> On 2020-06-22 14:11, Lee Jones wrote:
>> On Mon, 22 Jun 2020, Frank Rowand wrote:
>>
>>> On 2020-06-22 10:10, Lee Jones wrote:
>>>> On Mon, 22 Jun 2020, Frank Rowand wrote:
>>>>
>>>>> On 2020-06-22 03:50, Lee Jones wrote:
>>>>>> On Thu, 18 Jun 2020, Frank Rowand wrote:
>>>>>>
>>>>>>> On 2020-06-15 04:26, Lee Jones wrote:
>>>>>>>> On Sun, 14 Jun 2020, Frank Rowand wrote:
>>>>>>>>
>>>>>>>>> Hi Lee,
>>>>>>>>>
>>>>>>>>> I'm looking at 5.8-rc1.
>>>>>>>>>
>>>>>>>>> The only use of OF_MFD_CELL() where the same compatible is specified
>>>>>>>>> for multiple elements of a struct mfd_cell array is for compatible
>>>>>>>>> "stericsson,ab8500-pwm" in drivers/mfd/ab8500-core.c:
>>>>>>>>>
>>>>>>>>>         OF_MFD_CELL("ab8500-pwm",
>>>>>>>>>                     NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
>>>>>>>>>         OF_MFD_CELL("ab8500-pwm",
>>>>>>>>>                     NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
>>>>>>>>>         OF_MFD_CELL("ab8500-pwm",
>>>>>>>>>                     NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
>>>>>>>
>>>>>>>          OF_MFD_CELL("ab8500-pwm",
>>>>>>>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
>>>>>>>
>>>>>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>>>>>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
>>>>>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>>>>>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
>>>>>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>>>>>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
>>>>>>>
>>>>>>>>>
>>>>>>>>> The only .dts or .dtsi files where I see compatible "stericsson,ab8500-pwm"
>>>>>>>>> are:
>>>>>>>>>
>>>>>>>>>    arch/arm/boot/dts/ste-ab8500.dtsi
>>>>>>>>>    arch/arm/boot/dts/ste-ab8505.dtsi
>>>>>>>>>
>>>>>>>>> These two .dtsi files only have a single node with this compatible.
>>>>>>>>> Chasing back to .dts and .dtsi files that include these two .dtsi
>>>>>>>>> files, I see no case where there are multiple nodes with this
>>>>>>>>> compatible.
>>>>>>>>>
>>>>>>>>> So it looks to me like there is no .dts in mainline that is providing
>>>>>>>>> the three "stericsson,ab8500-pwm" nodes that drivers/mfd/ab8500-core.c
>>>>>>>>> is expecting.  No case that there are multiple mfd child nodes where
>>>>>>>>> mfd_add_device() would assign the first of n child nodes with the
>>>>>>>>> same compatible to multiple devices.
>>>>>>>>>
>>>>>>>>> So it appears to me that drivers/mfd/ab8500-core.c is currently broken.
>>>>>>>>> Am I missing something here?
>>>>>>>>>
>>>>>>>>> If I am correct, then either drivers/mfd/ab8500-core.c or
>>>>>>>>> ste-ab8500.dtsi and ste-ab8505.dtsi need to be fixed.
>>>>>>>>
>>>>>>>> Your analysis is correct.
>>>>>>>
>>>>>>> OK, if I'm not overlooking anything, that is good news.
>>>>>>>
>>>>>>> Existing .dts source files only have one "ab8500-pwm" child.  They already
>>>>>>> work correcly.
>>>>>>>
>>>>>>> Create a new compatible for the case of multiple children.  In my example
>>>>>>> I will add "-mc" (multiple children) to the existing compatible.  There
>>>>>>> is likely a better name, but this lets me provide an example.
>>>>>>>
>>>>>>> Modify drivers/mfd/ab8500-core.c to use the new compatible, and new .dts
>>>>>>> source files with multiple children use the new compatible:
>>>>>>>
>>>>>>>          OF_MFD_CELL("ab8500-pwm",
>>>>>>>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
>>>>>>>
>>>>>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>>>>>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
>>>>>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>>>>>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
>>>>>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>>>>>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
>>>>>>>
>>>>>>> The "OF_MFD_CELL" entry is the existing entry, which will handle current
>>>>>>> .dts source files.  The new "OF_MFD_CELL_REG" entries will handle new
>>>>>>> .dts source files.
>>>>>>
>>>>>> Sorry, but I'm not sure what the above exercise is supposed to solve.
>>>>>>
>>>>>> Could you explain it for me please?
>>>>>
>>>>> The OF_MFD_CELL() entry handles all of the existing .dts source files
>>>>> that only have one ab8500-pwm child nodes.  So existing .dtb blobs
>>>>> continue to work.
>>>>>
>>>>> The OF_MFD_CELL_REG() entries will handle all of the new .dts source
>>>>> files that will have up to 3 ab8500-pwm child nodes.
>>>>>
>>>>> Compatibility is maintained for existing .dtb files.  A new kernel
>>>>> version with the changes will support new .dtb files that contain
>>>>> multiple ab8500-pwm child nodes.
>>>>
>>>> I can see *what* you're trying to do.  I was looking for an
>>>> explanation of *how* you think that will work.  FWIW, I don't think
>>>> what you're proposing will work as you envisage.  I thought that
>>>> perhaps I was missing something, which is why I requested further
>>>> explanation.
>>>>
>>>>>>> And of course the patch that creates OF_MFD_CELL_REG() needs to precede
>>>>>>> this change.
>>>>>>>
>>>>>>> I would remove the fallback code in the existing patch that tries to
>>>>>>> handle an incorrect binding.  Just error out if the binding is not
>>>>>>> used properly.
>>>>>>
>>>>>> What fallback code?
>>>>>
>>>>> Based on reading the patch description, I expected some extra code to try
>>>>> to handle the case where the compatible in more than one struct mfd_cell
>>>>> entry is "stericsson,ab8500-pwm" and there are multiple ab8500-pwm child
>>>>> nodes.
>>>>>
>>>>> Looking at the actual code (which I had not done before), I see that the
>>>>> "best effort attempt to match" is keeping a list of child nodes that
>>>>> have already been used (mfd_of_node_list) and avoiding re-use of such
>>>>> nodes.  This allows an invalid .dtb (one with multple "stericsson,ab8500-pwm"
>>>>> child nodes) to possibly be assigned unique child nodes for multiple
>>>>> struct mfd_cell entries to be "".
>>>>>
>>>>> So it is confusing for me to call that "fallback code".  It really is
>>>>> "best effort attempt to match" for a broken .dtb code.
>>>>>
>>>>> There should be no best effort for a broken .dtb.  The broken .dtb should
>>>>> instead result in an error.
>>>>
>>>> The problem is, how can you tell the difference between a valid and a
>>>> broken FDT without pre-processing - which, as I explained in the
>>>> commit message, I am not prepared to do.  We cannot test individually
>>>> since all configurations (e.g. no 'reg' property are valid on an
>>>> individual basis.
>>>
>>> If my proposed changes are made, then there are at least 3 ways to detect
>>> a broken FDT or prevent the problem caused by the broken FDT.
>>>
>>>
>>> 1) Use the validation process that uses the bindings to validate the
>>> devicetree source.
>>
>> Could you provide an example please?
> 
> I'm sorry I don't have a concise description and example.  I have not been
> keeping up with the state of the art in this area.
> 
> A terribly non-precise pointer to the general area is:
> 
>   https://elinux.org/Device_tree_future#Devicetree_Verification

I haven't had time to search for an excellent resource yet, but following
the above URL, the is a Linaro Connect slide set from Grant Likely that
provides a somewhat high level conceptual view.  You can skim through
the slides pretty fast:

   https://elinux.org/images/6/67/Hkg18-120-devicetreeschema-grantlikely-180404144834.pdf

A very high level overview is that the bindings documents in the Linux
kernel source tree at Documentation/devicetree/bindings/ are being
converted to a YAML format that can be processed by the verification
tools.  The verification tools can use the bindings to check whether
a devicetree source follows the definition of the bindings for each
of the nodes.

A random example of a binding that has been converted to YAML is

   Documentation/devicetree/bindings/rng/st,stm32-rng.yaml

In the specific case that this patch series addresses, the
Documentation/devicetree/bindings/mfd/ab8500.txt binding has not been
converted to YAML yet.  If it was YAML, it should specify the properties
for a child node with compatible value "stericsson,ab8500-pwm" is not
allowed to have a "reg" property.  A new compatible should be
added for child nodes that are required to have a "reg" property.
In my suggestion above I chose "ab8500-pwm-mc" for this new compatible.
That is probably a terrible name, Rob would probably have a better
suggestion.

Given such a YAML binding, the verification tool would report an error
for any child node with compatible "stericsson,ab8500-pwm" and containing
a "reg" property.  It would also report an error for any child node
with compatible "ab8500-pwm-mc" that was missing the required "reg"
property.

-Frank

> 
> As a general comment, I think that validation / verification is a very
> valuable tool, but the schemas to support it are an ongoing project.
> 
> Even after the schemas are all in place, it will still be possible for
> bad FDTs to be fed to the kernel, so it is not a total pancea.
> 
>>
>>> 2) Modify patch 1/3.  The small part of the patch to modify is:
>>>
>>> +static int mfd_match_of_node_to_dev(struct platform_device *pdev,
>>> +				    struct device_node *np,
>>> +				    const struct mfd_cell *cell)
>>> +{
>>> +	struct mfd_of_node_entry *of_entry;
>>> +	const __be32 *reg;
>>> +	u64 of_node_addr;
>>> +
>>> +	/* Skip devices 'disabled' by Device Tree */
>>> +	if (!of_device_is_available(np))
>>> +		return -ENODEV;
>>> +
>>> +	/* Skip if OF node has previously been allocated to a device */
>>> +	list_for_each_entry(of_entry, &mfd_of_node_list, list)
>>>
>>> Change:
>>>
>>> +		if (of_entry->np == np)
>>> +			return -EAGAIN;
>>>
>>> To:
>>>
>>> +		if (of_entry->np == np) {
>>> +			if (!cell->use_of_reg)
>>> +				return -EINVAL;
>>> +			else
>>> +				return -EAGAIN;
>>>
>>> There may be a better choice than EINVAL, but I am just showing the method.
>>>
>>> You may also want to refactor this section of the patch slightly
>>> differently to achieve the same result.  It was just easiest to
>>> show the suggested change the way I did it.
>>>
>>> The test that returns EINVAL detects the issue that the FDT does
>>> not match the binding (there is more one child node with the
>>> "stericsson,ab8500-pwm" compatible.
>>
>> So here, instead of just failing a single device, we fail everything?
>> Sounds a lot like throwing the baby out with the bath water.  How is
>> that an improvement?

You can modify more extensively than my simple example, changing
mfd_add_device() to more gracefully handle an EINVAL returned by
mfd_match_of_node_to_dev().


>>
>>> 3) I'm not sure if the pre-parsing that is wanted is parsing of the
>>> devicetree or parsing of the struct mfd_cell array.  If the mfd_cell
>>> array then solution 3 is not acceptable.
>>>
>>> A different change to a small part of patch 1/3.  In mfd_add_devices(),
>>> validate parameter "cells".  The validation could precede the existing
>>> code, or it could be folded into the existing for loop.  The validation
>>> is checking for any other element of the cells array containing
>>> the same compatible value if cell->use_of_reg is not true for an element.
>>>
>>> If this validation occurs, then I think mfd_of_node_list, and all the
>>> associated code to deal with it is no longer needed.  But I didn't
>>> look at this part in detail, so maybe I missed something.
>>>
>>> The validation is something like (untested):
>>>
>>> 	if (IS_ENABLED(CONFIG_OF)
>>> 		for (i = 0; i < n_devs; i++) {
>>> 			this_cell = cells + i;
>>> 			if (!this_cell->use_of_reg) {
>>> 				for (j = 1; j < n_devs; j++) {
>>> 					if (j != i) {
>>> 						cell = cells + j;
>>> 						if (!strcmp(this_cell->of_compatible, cell->of_compatible))
>>> 							return -EINVAL;
>>> 					}
>>> 				}
>>> 			}
>>> 		}
>>
>> I think I just threw-up a little. ;)
> 
> I'm not surprised.
> 
> But it actually is pretty simple code.
> 
>>
>> Did you read the commit message?
> 
> Yes, I did.
> 
>>
>>   "We could code around this with some pre-parsing semantics, but the
> 
> And as I said above, it was not clear to me what was meant by pre-parsing.
> 
>>   added complexity required to cover each and every corner-case is not
>>   justified.  Merely patching the current failing (via this patch) is
>>   already working with some pretty small corner-cases"
>>   
>> Providing thorough pre-parsing would be highly complex and highly
>> error prone.  The example you provide above is not only ugly, there
>> are numerous issues with it.  Not least:
>>
>>  * Only one corner-case is covered
> 
> I agree with this.  I also agree it is a fool's errand to try to add
> code to fully validate all possible devicetree source errors in
> driver source.
> 
>>  * Validation is only completed on a single mfd_cells struct
> 
> On a single _array_ of struct mfd_cells.  But this does appear
> to be a fatal flaw.  I had not looked at enough callers of
> mfd_add_devices() to see that it is a common pattern for
> a single driver to call it multiple times.
> 
>>  * False positives can occur and will fail as a result
> 
> ((What is an example of a false positive?))  Never mind, now that
> I see that the previous issue is a fatal flaw, this becomes
> academic.
> 
>>
>> The above actually makes the solution worse, not better.
>>
> 
> Patch 1/3 silently fails to deal with a broken devicetree.
> It results on one of the three ab8500-pwm child nodes in
> the hypothetical devicetree source tree not being added.
> 
> That is not a good result either.
> 
> OK, so my solution #3 is a no go.  How about my solution #2,
> which you did not comment on?
> 
> -Frank
> .
> 

