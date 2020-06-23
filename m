Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3620677A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 00:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbgFWWr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 18:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387736AbgFWWrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:47:19 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67DAC06125C;
        Tue, 23 Jun 2020 15:33:52 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id u17so202282qtq.1;
        Tue, 23 Jun 2020 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J8G2am4LycnAoPLOy+2PS7RCIcbIIa4nJGScou/N4W8=;
        b=NbH3sery+/Qe5M40n5bdjBcoiYiE3l/d8UHQTfPCYMYi3BdKqONQPoqDli8+EA5JKC
         IVQOZbdSWI6kXX5j3ScGn6Eaj0VR3rlRQejfbPk+oHZ3z9/WT3qmu0mzQT7qlUhUJGLI
         QUvKVsFcDlt2puXh1OLK4+GrD3sdbpogQu5+9a7zPF8vJ4KmOHS/87QCC6aPhhEjmRRU
         Bf9rceKTtbL1V7ks2M+eAp7KPq2bb/kw5lK4k9t9ymUSFnzCaCXuG5e7zIA7/snQw7c6
         cBffxrwyUwdN/VKikJjX0yHlM/GLSIz15+BsgMT2MfNoRYJgo68iwuthaFMU6xzDPeOR
         T0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J8G2am4LycnAoPLOy+2PS7RCIcbIIa4nJGScou/N4W8=;
        b=Fmf9rnC0CjOYznmvWEMityEhmSszuDf6GePhBcwhals+Auub+xwVH2PuSOW1QNCais
         ia5CjjnSW7ByoUz72RBmZ1aLUkgoNA/RYmQnLXpRqajzG7Qo4wtYcy62h3HXFrZPwtrl
         9GOIyxeB3TNTfaItL0SZg+kkUMUJis0Yd8dciainkclXYM/h3s0f798SaPcBggnWDqq1
         6FsMl0DJFFvkPwbnbAaeo5sEdR75ze/lS1KaBnZivc2y3utJ08jqgYUh7OWyfdCN/y1/
         YtiPPFgvN8isvnuaxrwegDlX3sW9hNhZIvMp0+fBCwDrSXHx7PpK+f8ury7AXt/SMaAH
         WO3A==
X-Gm-Message-State: AOAM533llgzP/Sv4+sQOrt0xKeCGHRlLciDPwZky33kX0v3sbKMtdgbP
        f9WVu7s3PXcjVdH3j+a24Ew=
X-Google-Smtp-Source: ABdhPJzff2BzkTOKO8KMvzYPVoeW5pH9NHD3WiGMrgK3El1HJApgdwBVLcyX2leKK5rB5wg3UXXupQ==
X-Received: by 2002:ac8:1090:: with SMTP id a16mr24391486qtj.181.1592951631945;
        Tue, 23 Jun 2020 15:33:51 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a185sm1685060qkg.3.2020.06.23.15.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 15:33:51 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
References: <20200615092644.GA2608702@dell>
 <eef50a78-8571-5600-4fee-c824fd4a7f69@gmail.com>
 <20200622085009.GP954398@dell>
 <cd8952da-cc55-8087-b9f6-876417beb188@gmail.com>
 <20200622151054.GW954398@dell>
 <037c0fd2-df35-5981-7ef2-c6199841650d@gmail.com>
 <20200622191133.GY954398@dell>
 <dc893ce4-8a4d-b7d9-8591-18a8b9b2ea2b@gmail.com>
 <20200623064723.GZ954398@dell>
 <83f2be78-1548-fa2b-199a-2391b2eceb47@gmail.com>
 <20200623195905.GB954398@dell>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6684101d-1013-2964-c247-394f9b12a194@gmail.com>
Date:   Tue, 23 Jun 2020 17:33:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623195905.GB954398@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-23 14:59, Lee Jones wrote:
> Suggestion #2
> 
>>>>>> 2) Modify patch 1/3.  The small part of the patch to modify is:
>>>>>>
>>>>>> +static int mfd_match_of_node_to_dev(struct platform_device *pdev,
>>>>>> +				    struct device_node *np,
>>>>>> +				    const struct mfd_cell *cell)
>>>>>> +{
>>>>>> +	struct mfd_of_node_entry *of_entry;
>>>>>> +	const __be32 *reg;
>>>>>> +	u64 of_node_addr;
>>>>>> +
>>>>>> +	/* Skip devices 'disabled' by Device Tree */
>>>>>> +	if (!of_device_is_available(np))
>>>>>> +		return -ENODEV;
>>>>>> +
>>>>>> +	/* Skip if OF node has previously been allocated to a device */
>>>>>> +	list_for_each_entry(of_entry, &mfd_of_node_list, list)
>>>>>>
>>>>>> Change:
>>>>>>
>>>>>> +		if (of_entry->np == np)
>>>>>> +			return -EAGAIN;
>>>>>>
>>>>>> To:
>>>>>>
>>>>>> +		if (of_entry->np == np) {
>>>>>> +			if (!cell->use_of_reg)
>>>>>> +				return -EINVAL;
>>>>>> +			else
>>>>>> +				return -EAGAIN;
>>>>>>
>>>>>> There may be a better choice than EINVAL, but I am just showing the method.
>>>>>>
>>>>>> You may also want to refactor this section of the patch slightly
>>>>>> differently to achieve the same result.  It was just easiest to
>>>>>> show the suggested change the way I did it.
>>>>>>
>>>>>> The test that returns EINVAL detects the issue that the FDT does
>>>>>> not match the binding (there is more one child node with the
>>>>>> "stericsson,ab8500-pwm" compatible.
> 
> My reply to suggestion #2
> 
>>>>> So here, instead of just failing a single device, we fail everything?
>>>>> Sounds a lot like throwing the baby out with the bath water.  How is
>>>>> that an improvement?

I could have sworn that I had replied with a solution to this issue.  So I
searched and searched and searched my emails in the thread.  And checked my
drafts email folder.  Then finally realized I had made a stupid mistake.

I did reply about this, but I had put my "-Frank" signature at the end
of a comment much higher in the email.  So of course I expect you stopped
reading at that point and never saw my answer.  My apologies!!!

The email in question is:

  https://lore.kernel.org/linux-devicetree/eae9cc00-e67a-cb6a-37c2-f2235782ed77@gmail.com/

and what I wrote at this point in that email is:

  You can modify more extensively than my simple example, changing
  mfd_add_device() to more gracefully handle an EINVAL returned by
  mfd_match_of_node_to_dev().

Thus a modification to my suggestion #2 to make it _not_ fail
everything.

I didn't really flesh out all that "more gracefully handle" means.
Among other things, it could include a pr_warn() that provides
a fairly specific possible cause of the problem (eg the corner
case mentioned near the end of the patch 1/3 header that shows
mixing OF_MFD_CELL() and OF_MFD_CELL_REG() for the same compatible
value.  It may be tricky coming up with good phrasing in a pr_warn()
that describes the generic issue instead of the specific example.

Again, sorry.


>>>
>>> [0]
>>
>> Is "[0]" the patch series, especially patch 1/3?
> 
> No, this is my reply to your suggestion #2.
> 
> The [0] is referenced further down.
> 
> [...]
> 
>>>>>  * False positives can occur and will fail as a result
>>>>
>>>> ((What is an example of a false positive?))  Never mind, now that
>>>> I see that the previous issue is a fatal flaw, this becomes
>>>> academic.
>>>
>>> That's okay, I don't mind discussing.
>>>
>>> Ironically, the 'ab8500-pwm' is a good example of a false positive,
>>> since it's fine for the DT nodes to be identical.  So long as there
>>> are nodes present for each instance, it doesn't matter which one is
>>> allocated to which device .Forcing a 'reg' property onto them for no> good reason it not a valid solution here.
>>

Start of my comment that I wrote with "too many shortcuts" (see below):

>> I thought that one of the points of this patch series was to add a
>> "reg" property to any mfd child that was described by the
>> OF_MFD_CELL_REG() macro.
> 
> The OF_MFD_CELL_REG() macro didn't exist until this patch-set.

  
Maybe the way I wrote that took too many shortcuts.  Let me re-phrase.

I thought that one of the points of this patch set was to add the
of_reg and use_of_reg fields to struct mfd_cell.  The expected use
of the of_reg and use_of_reg fields was to allow the presence of a
"reg" property in a devicetree mfd child node to be used to match
specific child nodes to specific elements of the mfd_add_devices()
cell array parameter, with the match occurring when the array elements
are processed (currently in mfd_match_of_node_to_dev(), which is
called by mfd_add_device()).

The key point being the matching specific devicetree mfd child nodes
to specific cell array members.

The OF_MFD_CELL_REG() is simply a helper macro related to the above.

> 
> There are currently no users.

Yes.  And as I pointed out elsewhere, I would expect a user of new
functionality to be added as part of a patch series that adds the
new functionality.  Or at least a mention of a specific plan to
use the functionality.

I had been assuming that the intended user was the one use case that
I had identified, and that you let me continue to assume was the one
existing use case.

> 
>> And that was meant to fix the problem where multiple indistinguishable
>> children existed.  The only instance I found of that (using the
>> weak search on OF_MFD_CELL()) was of compatible "stericsson,ab8500-pwm"
>> in drivers/mfd/ab8500-core.c.  You agreed with my email that
>> reported that.
> 
> No, I agreed with you that there is a current problem with
> "stericsson,ab8500-pwm", as identified by Michael.  I didn't actually
> know about this issue until *after* drafting this patch-set.  To be
> clear the "stericsson,ab8500-pwm" scenario is not the reason for this
> set's existence.

So now I know that drivers/mfd/ab8500-core.c is totally unrelated to
this patch series, and not the intended user of the new functionality.

> 
> Also, please forget about the OF_MFD_* macros, they are totally
> agnostic to this effort.  The only relevance they have here is the
> addition of 1 extra macro which *could* be used to provide the 'reg'
> property where appropriate.

My point was that my search for the data that comprised the "cell"
parameter passed to mfd_add_devices() was inadequate, because I
was searching on OF_MFD_CELL() instead of mfd_add_devices.  I was
admitting that part of my ignorance was because of this poor search.

I was searching for where the problem case actually occurred in the
kernel.  Maybe you did not realize that I have been thinking that
the only place where the problem case occurred was the single case
I found with this insufficient search method.

In some or many or all (I don't know, I'm not going to go back
and search for all of them) you can probably replace mention
of the OF_MFD_* with either my search for input data to
mfd_add_devices() _or_ a concise reference to the new of_reg
and use_of_reg fields of struct mfd_cell and the use of the
new fields.

Where is the problem that the patch set was intended to fix?

> 
>> So I thought that drivers/mfd/ab8500-core.c would be modified to
>> replace the multiple instances of compatible "stericsson,ab8500-pwm"
>> in OF_MFD_CELL() with OF_MFD_CELL_REG().
> 
> That is not my vision.  There is no need for "stericsson,ab8500-pwm"
> to have 'reg' properties as far as I see it.

In that case the binding document for the mfd child node with
compatible "stericsson,ab8500-pwm" should be updated to state
that if there are multiple such child nodes with the same parent
then they must contain exactly the same set of properties and
values.

Maybe not your problem, I have no idea who is responsible for
that update.

However, 

> 
>> This is another problem with the patch series: there is no user
>> of OF_MFD_CELL_REG().  Please add one to the series.
> 
> That's not a problem with this patch-set, it's a problem with your
> understanding of this patch-set. :)

I have already responded above about whether there should be a user
of OF_MFD_CELL_REG() in the patch set.

> 
> As far as I know, there aren't any current users who would benefit
> from this work.

Sigh.  From the original patch 1/3 header:

  "Currently, when a child platform device (sometimes referred to as a
  sub-device) is registered via the Multi-Functional Device (MFD) API,
  the framework attempts to match the newly registered platform device
  with its associated Device Tree (OF) node.  Until now, the device has
  been allocated the first node found with an identical OF compatible
  string.  Unfortunately, if there are, say for example '3' devices
  which are to be handled by the same driver and therefore have the same
  compatible string, each of them will be allocated a pointer to the
  *first* node."

This implies that there is a current instance where multiple devices
are "allocated a pointer to the *first* node".

If the patch header had instead said something like:

  adding the ability for an mfd device to have multiple children
  with the same value of "compatible" property

then my whole approach to trying to analyze and understand the
patch series would have been entirely different.  One of my
early replies described my attempt to find the code that was
encountering the problem that the patch series claimed to fix.
One of my concerns was handling potential compatibility issues
with existing FDTs.

And my understanding of your response to my analysis and investigation
was that I had indeed found a problem case in existing code.  But now
you tell me that the driver and mfd child node compatible value that
I identified are not at all a problem.

> Instead, it is designed to provide future submitters
> with another tool to help them link their child devices to the correct
> OF nodes.

And that is what I was looking for above in this reply, looking for
a user of the new functionality in the patch series, where I stated:

   "Or at least a mention of a specific plan to
   use the functionality."


> That's not to say that current users can't and won't
> benefit from this.  Just that they are not the target audience.
> 
>>>>> The above actually makes the solution worse, not better.
>>>>>
>>>>
>>>> Patch 1/3 silently fails to deal with a broken devicetree.
>>>> It results on one of the three ab8500-pwm child nodes in
>>>> the hypothetical devicetree source tree not being added.
>>>>
>>>> That is not a good result either.
>>>
>>> No it doesn't.  In the case of 'ab8500-pwm' the OF node is not set for
>>> 2 of the devices and warnings are presented in the kernel log.
>>
>> OK, I was wrong about "silent".  There is a warning:
>>    pr_warn("%s: Failed to locate of_node [id: %d]\n",
>>
>>> The
>>> device will continue to probe and function as usual.
>>
>> If the device probes and functions as usual without the child of_node,
>> then why does the node have any properties (for the cases of
>> arch/arm/boot/dts/ste-ab8500.dtsi and arch/arm/boot/dts/ste-ab8505.dtsi
>> the properties "clocks" and "clock-names").
> 
> Because DT is meant to describe the hardware, not the implementation.
> 
> DT does not know, or care that in our case most operations that happen
> on the platform are passed back via an API to a central controlling
> location.  Or that in reality, the OF node in this situation is
> superfluous.
> 
> Can we please stop talking about the AB8500.  It doesn't have anything
> to do with this series besides the fact that if it (this set) had
> existed *before* 'ab8500-pwm' was OF enabled, it wouldn't now be
> wonky.

OK.  I now understand that you don't expect the new functionality of
the of_reg and use_of_reg fields of struct mfd_cell to be used by
in relation to "ab8500-pwm" and drivers/mfd/ab8500-core.c.  I will
drop them from the discussion.


> 
>> Digging through that leads to yet another related question, or actually
>> sort of the same question.  Why do the child nodes with compatible
>> "stericsson,ab8500-pwm" have the properties "clocks" and "clock-names"
>> since the binding Documentation/devicetree/bindings/mfd/ab8500.txt
>> does not list them?
> 
> If you want to talk about the AB8500, please start a new thread.
> 
>>>> OK, so my solution #3 is a no go.  How about my solution #2,
>>>> which you did not comment on?
>>>
>>> I did [0].  You must have missed it. :)
>>

>> But yes or no to my solution #2 (with some slight changes to
>> make it better (more gracious handling of the detected error) as
>> discussed elsewhere in the email thread)?
> 
> Please see "[0]" above!
> 
> AFAICT your solution #2 involves bombing out *all* devices if there is
> a duplicate compatible with no 'reg' property value.  This is a)
> over-kill and b) not an error, as I mentioned:

As I mentioned above, I set you up to have this misunderstanding by
a mistake in one of my earlier emails.  So now that I have pointed
out what I meant here by "more gracious handling of the detected
error", what do you think of my amended solution #2?

> 
>>> It also suffers with false positives.
> 

Sorry for the very long response, but it seemed we were operating
under some different understandings and I hope I have clarified some
things.

-Frank
