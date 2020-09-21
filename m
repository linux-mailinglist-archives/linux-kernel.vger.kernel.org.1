Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4EA2721A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIUK5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726768AbgIUK5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600685863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ozMNlIm+M+XDaiQXytzpgVC8ivYsZiXodOtq67f0/dk=;
        b=BHns3aMZeO4NTHwSE5/xEDTprxmWRKjuLF2SHy8fnDIV6z1RToDLWIOvlbcCVN436JaH+t
        PK5FnrCzJwDtNKfCRkqHJ3APmD67YiZeTNsbhm3JQh1WuDsrVvKvswzFLtpXiTiQpsnAOi
        3tQXDFAypkv9hDcSeg0eDoW8zGMxeLU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-j078i9J7MwG_BfUXOZIO0w-1; Mon, 21 Sep 2020 06:57:41 -0400
X-MC-Unique: j078i9J7MwG_BfUXOZIO0w-1
Received: by mail-ej1-f70.google.com with SMTP id w10so4674534ejq.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ozMNlIm+M+XDaiQXytzpgVC8ivYsZiXodOtq67f0/dk=;
        b=VFtRbdcovfxHMld8J/PJ7lJAYCXDFtDQO4oIGZB0nSvRGqAipp+40h5GW+GSp/nPIr
         jTlRi+Qj/TO0hJuEpytlFral4wOruI147WLHVOG/m60nHGhEHjW/h2bX7eHHUJ5lNfMC
         HPbSOICZzoJGQNH3O1uQ3ROEGUQq+s2HjXjkJ0GV8tLdXAT2iRzs+cjRa2eXlYUKeHG/
         CebnAyBI9h57ODMzivpV70ojR1kndsE1kYXim8NhcVMNk++8t1bjn3zbzisix7hdpDiD
         jYRTG3SRVsT9SMIcfJsdttKMvtrZSkfQiggjTeCZ1tOpVbKnB5UAlBJYUsC34ykEoWNj
         hkig==
X-Gm-Message-State: AOAM533+n5YcNoUGUwL4orGl8uU77W03gbzc9BXNT0TZUV6KPJtc9AA4
        g/sDlQWVNYdiytzXC6kBJTOumCukxZLgQvYCk8pS3pkKLFt+tEvUtOXQPfI6HPxo4E/HVLRtlgx
        tgmcbJ9fBJEIlyhc2+DA8f/iL
X-Received: by 2002:a17:906:e918:: with SMTP id ju24mr47862623ejb.442.1600685860022;
        Mon, 21 Sep 2020 03:57:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOJPPqcnCEHx7/ET//Ts1zn5e0ZKbaXLJ5uD4pKcU7hg7BRf4E/da6zxKOrs5Kp8D4j+qj+g==
X-Received: by 2002:a17:906:e918:: with SMTP id ju24mr47862603ejb.442.1600685859725;
        Mon, 21 Sep 2020 03:57:39 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v2sm8711414ejh.57.2020.09.21.03.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:57:39 -0700 (PDT)
Subject: Re: [PATCH v3] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     Divya Bharathi <divya27392@gmail.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Divya Bharathi <divya_bharathi@dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>
References: <20200917065550.127400-1-divya_bharathi@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2795ca15-59b1-8435-14ef-6e0c1d532b22@redhat.com>
Date:   Mon, 21 Sep 2020 12:57:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917065550.127400-1-divya_bharathi@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As usual, first a review of the userspace API.

Note the biggest pending issue with the userspace API is if
we are going to keep this under /sys/devices/platform/dell-wmi-sysman/
or if we are going to have it under:

/sys/class/firmware-attributes/dell-wmi-sysman/

That is still being discussed in the v1 thread.

On 9/17/20 8:55 AM, Divya Bharathi wrote:
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
> Cc: mark gross <mgross@linux.intel.com>
> 
> Co-developed-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Co-developed-by: Prasanth KSR <prasanth.ksr@dell.com>
> Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>
> Signed-off-by: Divya Bharathi <divya_bharathi@dell.com>
> ---
> 
> Changes from v2 to v3:
>   - Fix a possible NULL pointer error in init
>   - Add missing newlines to all dev_err/dev_dbg/pr_err/pr_debug statements
>   - Correct updating passwords when both Admin and System password are set
>   - Correct the WMI driver name
>   - Correct some namespace clashing when compiled into the kernel (Reported by Mark Gross)
>   - Correct some comment typos
>   - Adopt suggestions made by Hans:
>     + Use single global mutex
>     + Clarify reason for uevents with a comment
>     + Remove functions for set and get current password
>     + Rename lower_bound to min_value and upper_bound to max_value
>     + Rename possible_value to possible_values
>     + Remove references to float
>     + Build a separate passwords directory again since it behaves differently from the other
>       attributes
>     + Move more calls from pr_err -> dev_err
>   - Documentation cleanups (see v2 patch feedback)
>     + Grouping types
>     + Syntax of `modifier` output
> 
> Changes from v1 to v2:
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
>   .../testing/sysfs-platform-dell-wmi-sysman    | 175 ++++++
>   MAINTAINERS                                   |   9 +
>   drivers/platform/x86/Kconfig                  |  12 +
>   drivers/platform/x86/Makefile                 |   8 +
>   .../x86/dell-wmi-biosattr-interface.c         | 197 ++++++
>   .../platform/x86/dell-wmi-enum-attributes.c   | 208 +++++++
>   .../platform/x86/dell-wmi-int-attributes.c    | 189 ++++++
>   .../x86/dell-wmi-passobj-attributes.c         | 165 +++++
>   .../x86/dell-wmi-passwordattr-interface.c     | 167 +++++
>   .../platform/x86/dell-wmi-string-attributes.c | 171 +++++
>   .../platform/x86/dell-wmi-sysman-attributes.c | 589 ++++++++++++++++++
>   .../platform/x86/dell-wmi-sysman-attributes.h | 137 ++++
>   12 files changed, 2027 insertions(+)
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
> index 000000000000..03398ac11121
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-dell-wmi-sysman
> @@ -0,0 +1,175 @@
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
> +		Attributes can accept a set of pre-defined valid values (enumeration)
> +		or a range of numerical values (integer) or a string.
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
> +		suppressed, if/if-not attribute Y is configured.
> +
> +		modifier rules can be in following format,
> +		[ReadOnlyIf:<attribute>=<value>]
> +		[ReadOnlyIfNot:<attribute>=<value>]
> +		[SuppressIf:<attribute>=<value>]
> +		[SuppressIfNot:<attribute>=<value>]
> +
> +		For example,
> +		AutoOnFri/modifier has value,
> +			[SuppressIfNot:AutoOn=SelectDays]
> +		This means AutoOnFri will be supressed in BIOS setup if AutoOn
> +		attribute is not "SelectDays" and its value will not be effective
> +		through sysfs until this rule is met.

As discussed in the v1 thread, this is somewhat Dell specific and we make the
sysfs interface generic and move this to /sys/class/firmware-attributes/dell-wmi-sysman/
then this should probably be prefixed with dell- (and moved to a separate section
of this file for vendor extensions to the generic part)

> +
> +		"enumeration"-type specific properties:
> +
> +		possible_values:	A file that can be read to obtain the possible
> +		values of the <attr>. Values are separated using semi-colon.
> +
> +		value_modifier:	A file that can be read to obtain value-level
> +		dependency. This file is similar to modifier but here, an attribute's
> +		current value will be forcefully changed based dependent attributes
> +		value.
> +
> +		value_modifier rules can be in following format,
> +		<value>[ForceIf:<attribute>=<value>]
> +		<value>[ForceIfNot:<attribute>=<value>]
> +
> +		For example,
> +		LegacyOrom/value_modifier has value,
> +			Disabled[ForceIf:SecureBoot=Enabled]
> +		This means LegacyOrom's current value will be forced to "Disabled"
> +		in BIOS setup if SecureBoot is Enabled and its value will not be
> +		effective through sysfs until this rule is met.

Are value_modifiers only valid for enums? If not this should be moved to
the generic properties (or to the vendor extensions part)

> +
> +		"integer"-type specific properties:
> +
> +		min_value:	A file that can be read to obtain the lower
> +		bound value of the <attr>
> +
> +		max_value:	A file that can be read to obtain the upper
> +		bound value of the <attr>
> +
> +		scalar_increment:	A file that can be read to obtain the
> +		resolution of the incremental value this attribute accepts.
> +
> +		"string"-type specific properties:
> +
> +		max_length:	A file that can be read to obtain the maximum
> +		length value of the <attr>
> +
> +		min_length:	A file that can be read to obtain the minimum
> +		length value of the <attr>
> +
> +What:		/sys/devices/platform/dell-wmi-sysman/passwords/
> +Date:		December 2020
> +KernelVersion:	5.10
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +
> +		A BIOS Admin password and System Password can be set, reset or
> +		cleared using these attributes. An "Admin" password is used for
> +		preventing modification to the BIOS settings. A "System" password is
> +		required to boot a machine.
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
> +
> +		Note, password management is session specific. If Admin/System
> +		password is set, same password must be writen into current_password
> +		file (requied for pasword-validation) and must be cleared once the
> +		session	is over. For example,
> +			echo "password" > current_password
> +			echo "disabled" > TouchScreen/current_value
> +			echo "" > current_password

So I know this was mentioned before already but one concern I have here
is that there is a race where other users with write access to say TouchScreen/current_value
may change it between the setting and the clearing of the current_password even if
they don't have the password.

This is esp. relevant with containers. I'm not aware about all the intrinsics of
sysfs and containers, at a minimum we need to check if it is possible to disallow
all writes to the attributes when sysfs is mounted inside a container (so outside of the
main filesystem namespace).

If someone is reading along who happen to knows this, please enlighten me :)

> +
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
> +		Note, userspace applications need to follow below steps for efficient
> +		BIOS management,
> +		1.	Check if admin password is set. If yes, follow session method for
> +			password management as briefed under password section above.
> +		2.	Before setting any attribute, check if it has any modifiers
> +			or value_modifiers. If yes, incorporate them and then modify
> +			attribute.

OK, so as also mentioned in the v1 thread, I would like to see the uevent disappear
since it is somewhat of a heavy mechanism and not necessary when userspace specifically
cares about a single sysfs attribute changing.

Instead we can allow userspace to use poll() for POLL_PRI on this file to be notified
when it goes from 0 -> 1. See the v1 thread for some example code how to wake the
poll() in this case.

Regards,

Hans

