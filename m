Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB0C268904
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgINKLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:11:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47118 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726239AbgINKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600078288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8s0KjaG0YDdMbGkXjaaV8Z1zLXD1N8RTv/bKOJnEgc=;
        b=I35HbDqZNBccl+ghSz1mfu+F6Gq3o4IZgq2FCJxsviCLd0vblAUEMlNROpHKP0UxZqmuUq
        29AtyiiPVulAYnATqRXR97nfqS5gdJ1Xlxerz9Owmf16Koe9ltin3LJbgKQ+C95grWCBY/
        EAbmzE6P9DaCYaq/5LTTPooJR3e21YQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-ug3LPoleOn2YZg9PR1A9hA-1; Mon, 14 Sep 2020 06:11:26 -0400
X-MC-Unique: ug3LPoleOn2YZg9PR1A9hA-1
Received: by mail-ej1-f70.google.com with SMTP id b23so7898595ejv.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U8s0KjaG0YDdMbGkXjaaV8Z1zLXD1N8RTv/bKOJnEgc=;
        b=MfFGxf4UfdPmiY9Wa1Xr4wTflxFDqIFh7SFoy8+y3RfSrhMuHCwlITd7l5ciYjWetE
         rO3CKnLf80PYjIV7NCMAVcae7Op3/W+G8wtNY476OaOhI+dHG7X+rF9CRbzeAKtVUMar
         ME1twTYlGJOU1/OV/siOb5uKPhCGR37aA31gSztkjXtL943FF/civDIPa9hJTH3psTWr
         I8xDfAzMhHRzCFG/yxtiK9v4bvdxqEJc+7J6nM63OTsmKzBa1hvqdKFHeiNjS6EefzqJ
         YTpkVkyU7tGl5hor9HvLdok51oFWLWyXFxhiTE97spYXodiVrmwfaL2lqNAjmhD9YIFO
         p9Hw==
X-Gm-Message-State: AOAM533+f1XTcinUMxkVbXTEkyWZ2STTzF4UYv/ClQ8LhVB/mknszkYh
        8UMJWBmd8RxoLl6lIwu/G5xS8HU235l1jAXhKMxz8RsGp4alAVCPuw9sjqFQjG9xdr4YyKQj/Jw
        8GUw2D7p1PMs8OMDOiyWN7kXM
X-Received: by 2002:a17:906:6a82:: with SMTP id p2mr13812042ejr.3.1600078285047;
        Mon, 14 Sep 2020 03:11:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXvxnQufBEpwIlFfS/lY90f7C2abJ269dLpBglbR41CZRRI68G74cecHWzyOaAAFvTxcr0VA==
X-Received: by 2002:a17:906:6a82:: with SMTP id p2mr13812025ejr.3.1600078284757;
        Mon, 14 Sep 2020 03:11:24 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id y24sm8890726eds.35.2020.09.14.03.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 03:11:24 -0700 (PDT)
Subject: Re: [PATCH v2] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     Divya Bharathi <divya27392@gmail.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Divya Bharathi <divya_bharathi@dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>
References: <20200904142846.5356-1-divya_bharathi@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <26ddd2ea-a520-751b-d9f2-6667feb7edfa@redhat.com>
Date:   Mon, 14 Sep 2020 12:11:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904142846.5356-1-divya_bharathi@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Like last-time I will split this review in 2,
this first email will focus on the sysfs API/ABI part only.

On 9/4/20 4:28 PM, Divya Bharathi wrote:
> The Dell WMI Systems Management Driver provides a sysfs
> interface for systems management to enable BIOS configuration
> capability on certain Dell Systems.
> 
> This driver allows user to configure Dell systems with a
> uniform common interface. To facilitate this, the patch
> introduces a generic way for driver to be able to create
> configurable BIOS Attributes available in Setup (F2) screen.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Co-developed-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Co-developed-by: Prasanth KSR <prasanth.ksr@dell.com>
> Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>
> Signed-off-by: Divya Bharathi <divya_bharathi@dell.com>
> ---
> 
> ChangeLog from v1 to v2:
>   - use pr_fmt instead of pr_err(DRIVER_NAME
>   - re-order variables reverse xmas tree order
>   - correct returns of -1 to error codes
>   - correct usage of {} on some split line statements
>   - Refine all documentation deficiencies suggested by Hans
>   - Merge all attributes to a single directory
>   - Overhaul WMI interface interaction as suggested by Hans
>     * Move WMI driver registration to start of module
>     * Remove usage of lists that only use first entry for WMI interfaces
>     * Create a global structure shared across interface source files
>     * Make get_current_password function static
>     * Remove get_pending changes function, shared across global structure now.
> - Overhaul use of mutexes
>     * Make kset list mutex shared across source files
>     * Remove unneeded dell-wmi-sysman call_mutex
>     * Keep remaining call_mutexes in WMI functions
> - Move security area calculation into a function
> - Use NLS helper for utf8->utf16 conversion
> 
>   .../testing/sysfs-platform-dell-wmi-sysman    | 126 ++++
>   MAINTAINERS                                   |   9 +
>   drivers/platform/x86/Kconfig                  |  12 +
>   drivers/platform/x86/Makefile                 |   8 +
>   .../x86/dell-wmi-biosattr-interface.c         | 198 ++++++
>   .../platform/x86/dell-wmi-enum-attributes.c   | 214 +++++++
>   .../platform/x86/dell-wmi-int-attributes.c    | 195 ++++++
>   .../x86/dell-wmi-passobj-attributes.c         | 168 +++++
>   .../x86/dell-wmi-passwordattr-interface.c     | 200 ++++++
>   .../platform/x86/dell-wmi-string-attributes.c | 177 ++++++
>   .../platform/x86/dell-wmi-sysman-attributes.c | 572 ++++++++++++++++++
>   .../platform/x86/dell-wmi-sysman-attributes.h | 132 ++++
>   12 files changed, 2011 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-wmi-sysman
>   create mode 100644 drivers/platform/x86/dell-wmi-biosattr-interface.c
>   create mode 100644 drivers/platform/x86/dell-wmi-enum-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-int-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-passobj-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-passwordattr-interface.c
>   create mode 100644 drivers/platform/x86/dell-wmi-string-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman-attributes.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-dell-wmi-sysman b/Documentation/ABI/testing/sysfs-platform-dell-wmi-sysman
> new file mode 100644
> index 000000000000..e4b608275ea4
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-dell-wmi-sysman
> @@ -0,0 +1,126 @@
> +What:		/sys/devices/platform/dell-wmi-sysman/attributes/
> +Date:		December 2020
> +KernelVersion:	5.10
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +Description:
> +		The Dell WMI Systems Management Driver provides a sysfs interface
> +		for systems management software to enable BIOS configuration
> +		capability on certain Dell systems. This directory exposes
> +		interfaces for interacting with BIOS attributes.
> +
> +		Attributes can accept a set of pre-defined valid values or a range of
> +		numerical values or a string. An atribute can accept float as well,
> +		if so '.' is used as decimal separator.

Please replace: "An atribute" with "A numerical attribute", note this also fixes
a typo in attribute. Also this still deels a bit handwavy, if currently all used
numerical values are integers, lets just forget about floats for now and add
floats later as a separate type, to me that seems more sensible then having
a magical numerical type which can represent both.

> +
> +		Also, BIOS Admin password and System Password can be set, reset or
> +		cleared using these attributes. An "Admin" password is used for
> +		preventing modification to the BIOS settings. A "System" password is
> +		required to boot a machine.

Please add a paragraph for the type sysfs-attribute here, e.g.:

		type: Give the type of <attr>, this may be one of "integer", "string",
		"enum" and "password"


> +
> +		current_value:	A file that can be read to obtain the current
> +		value of the <attr>
> +
> +		This file can also be written to in order to update
> +		the value of a <attr>
> +
> +		default_value:	A file that can be read to obtain the default
> +		value of the <attr>
> +
> +		display_name:	A file that can be read to obtain a user friendly
> +		description of the at <attr>
> +
> +		display_name_language_code:	A file that can be read to obtain
> +		the IETF language tag corresponding to the "display_name" of the <attr>
> +
> +		modifier:	A file that can be read to obtain attribute-level
> +		dependency rule. It says an attribute X will become read-only or
> +		suppressed,	if attribute Y is not configured.
> +		For example, AutoOnHr becomes read-only if AutoOn is disabled

This still does not specify the syntax, if I do:

cat /sys/devices/platform/dell-wmi-sysman/attributes/AutoOnHr/modifier

What will the output be? and how should other software interpret that output?

> +
> +		possible_value:	A file that can be read to obtain the possible
> +		values of the <attr>. Values are separated using semi-colon.

This one is valid for enums only, right ? The above sysfs-attributes are all
generic, which is fine. But please add some separate headings for attributes which
are only value for a specific type, e.g.:

"enum"-type specific attributes:

	possible_value:...

Also shouldn't this be named possible_values? note the extra 's' at the end.

> +
> +		value_modifier:	A file that can be read to obtain value-level
> +		dependency. This file is similar to modifier but here, an attribute's
> +		current value will be forcefully changed based dependent attributes
> +		value.
> +		For example, current value of LegacyOrom will become Disabled if
> +		SecureBoot is Enabled.
> +

Please group this together with modifier (in the section with sysfs-attributes
which are common to all types) and also this needs a lot better explanation / documentation.

> +		lower_bound:	A file that can be read to obtain the lower
> +		bound value of the <attr>
> +
> +		upper_bound:	A file that can be read to obtain the upper
> +		bound value of the <attr>
> +
> +		scalar_increment:	A file that can be read to obtain the
> +		resolution of the incremental value this attribute accepts.

Please put all 3 under:

"integer"-type specific attributes:

So that you get:

"integer"-type specific attributes:

	lower_bound:	...

	upper_bound:	...

	scalar_increment:	...

Also please rename lower_bound to min_value and upper_bound to max_value,
this makes its clearer that they apply to current_value and in general
makes it easier to understand what they do.


> +
> +		max_length:	A file that can be read to obtain the maximum
> +		length value of the <attr>
> +
> +		min_length:	A file that can be read to obtain the minimum
> +		length value of the <attr>

Please put these 2 under:

"string"-type specific attributes:


> +
> +		is_password_set:	A file that can be read
> +		to obtain flag to see if a password is set on <attr>
> +
> +		max_password_length:	A file that can be read to obtain the
> +		maximum length of the Password
> +
> +		min_password_length:	A file that can be read to obtain the
> +		minimum length of the Password
> +
> +		current_password: A write only value used for privileged access
> +		such as setting attributes when a system or admin password is set
> +		or resetting to a new password
> +
> +		new_password: A write only value that when used in tandem with
> +		current_password will reset a system or admin password.

Please put all 5 of these under:

"password"-type specific attributes:


> +
> +What:		/sys/devices/platform/dell-wmi-sysman/attributes/reset_bios
> +Date:		December 2020
> +KernelVersion:	5.10
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +Description:
> +		This attribute can be used to reset the BIOS Configuration.
> +		Specifically, it tells which type of reset BIOS configuration is being
> +		requested on the host.
> +
> +		Reading from it returns a list of supported options encoded as:
> +
> +			'builtinsafe' (Built in safe configuration profile)
> +			'lastknowngood' (Last known good saved configuration profile)
> +			'factory' (Default factory settings configuration profile)
> +			'custom' (Custom saved configuration profile)
> +
> +		The currently selected option is printed in square brackets as
> +		shown below:
> +
> +		# echo "factory" > sys/devices/platform/dell-wmi-sysman/attributes/reset_bios
> +
> +		# cat sys/devices/platform/dell-wmi-sysman/attributes/reset_bios
> +		# builtinsafe lastknowngood [factory] custom
> +
> +		Note that any changes to this attribute requires a reboot
> +		for changes to take effect.
> +
> +What:		/sys/devices/platform/dell-wmi-sysman/attributes/pending_reboot
> +Date:		December 2020
> +KernelVersion:	5.10
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +Description:
> +		A read-only attribute reads 1 if a reboot is necessary to apply
> +		pending BIOS attribute changes.
> +
> +			0:	All BIOS attributes setting are current
> +			1:	A reboot is necessary to get pending BIOS attribute changes
> +				applied
> +
> +


Regards,

Hans

