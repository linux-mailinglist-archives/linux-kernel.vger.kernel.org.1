Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA0C27C267
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgI2Kap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbgI2Kao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:30:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601375434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dctLvRWUr366SLKfz0l5YoU2HRzHFvIz5YnNCjpDFPw=;
        b=VAF97e6NU5rhyuBxenC5WmZzY7XZLkTKdDAS7387C/485IJLSAXwmguymdsL4BgQndrLhy
        lXMMSVq6UryX2QNombYzUCO2/D8ua33Li2WpcnBGrT2om48CZJ7o7Pw4vcmVHVto9sh6uw
        wNm3wKEwmuPRBQwdD+O2ELWl5SCYyZQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-SD3Iup_uN96ZchhUAfy_nA-1; Tue, 29 Sep 2020 06:30:32 -0400
X-MC-Unique: SD3Iup_uN96ZchhUAfy_nA-1
Received: by mail-ed1-f71.google.com with SMTP id f16so1941800edm.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dctLvRWUr366SLKfz0l5YoU2HRzHFvIz5YnNCjpDFPw=;
        b=bfbUgjeMgEgpZICbWZF/MQNW/ewmZlm6GJ7rBCzDIpJfJiBz3S5S/2IVQLgyWEMwWM
         Dt+9bcc4G4X6qcgpEsxeCKFB2hjiE5CtGmK8BzIWWLxu4Mp+Zk8VuWLdFkpsLk7asBst
         xj2kTIcnGqj8O7IKVO9J/bJKbX4JXycyMZs3VT+DicJLkaUK9oZi8ct2Vk/kKQ8YrvmG
         8Sh1vbDLf13DHSjJEJYuqQZx1g4uqzqYyxWhIOowbp58MabT8ghHNAE7TYb1P1N7VFGF
         AP83dM9SCvRIPn/A9WCqYR2HiD/u/tGwHocAwOmtCKdoBrvVeSj4jaI411si9YENg9Qk
         rYlw==
X-Gm-Message-State: AOAM531ZP1ylTmsppHIsEufDt35DJXoXoAZDsetex6TbgJr30joFSfpW
        PuDWhutrJm6NcbkP1ZlZnmBMnwBvjyQ3NLdivYIrHsN1VmVofmIoqF0cQMxLvhvrh020XPvdlPC
        Ooxy3xd+f5PWCCMLewbIrp7kL
X-Received: by 2002:a05:6402:cb4:: with SMTP id cn20mr2438330edb.369.1601375430092;
        Tue, 29 Sep 2020 03:30:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+sSfeUhDxzsdZHt+KaVC9dHYVxv8j4pfVnGmOX1bG4kP+F2sf8X8FN1E2mJct55D1Ye0DFw==
X-Received: by 2002:a05:6402:cb4:: with SMTP id cn20mr2438279edb.369.1601375429284;
        Tue, 29 Sep 2020 03:30:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p3sm5726524edp.28.2020.09.29.03.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 03:30:28 -0700 (PDT)
Subject: Re: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     Divya Bharathi <divya27392@gmail.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Divya Bharathi <divya.bharathi@dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>
References: <20200929025521.59573-1-divya.bharathi@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <38211cb0-78a5-a9ad-0438-ab7024f5d52f@redhat.com>
Date:   Tue, 29 Sep 2020 12:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929025521.59573-1-divya.bharathi@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/29/20 4:55 AM, Divya Bharathi wrote:
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
> Signed-off-by: Divya Bharathi <divya.bharathi@dell.com>
> ---
> 
> Changes from v4 to v5:
>   - Correct Kconfig description to not use "WMI" twice.
>   - s/is_authentication_set/is_enabled/
>   - Specify that all attributes are optional and take UTF8
>   - Change authentication type to "role" and "mechanism"
>   - Explain what semicolons are
>   - Adjust whitespace of documentation
> 
> Changes from v3 to v4:
>   - Create a firmware-attributes class and tie ksets to a virtual device in it
>   - Make modifier and value_modifier "dell only" attributes.
>   - Correct some errors caught by kernel build bot around missing prototypes
>   - Remove mutexes from populate_* functions and put in init_dell_bios_attrib_wmi instead
>   - Move all code into a subdirectory drivers/platform/x86/dell-wmi-sysman and remove dell-wmi-*
>     prefix on files
>   - Move all data structures into shared struct
>   - In alloc functions instead of kzalloc use kcalloc and check that there is no overflow
>     + Same check for other alloc_foo-data functions
>   -  populate_*: Move sysfs_create_group to end of the function to prevent race conditions
>   - Save kernel object into each data instance and only remove that rather than sysfs_remove_group
>   - Document in sysfs file what causes change uevents to come through
>   - Only notify with change uevent one time on multiple settings modifications
>   - Adjust lots of string handling
>   - Make more objects static
>   - Various whitespace corrections
>   - Document map_wmi_error properly
>   - Bump version to 5.11 (February 2021)
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
>   - Overhaul use of mutexes
>     * Make kset list mutex shared across source files
>     * Remove unneeded dell-wmi-sysman call_mutex
>     * Keep remaining call_mutexes in WMI functions
>   - Move security area calculation into a function
>   - Use NLS helper for utf8->utf16 conversion
> 
>   .../testing/sysfs-class-firmware-attributes   | 219 +++++++
>   MAINTAINERS                                   |   8 +
>   drivers/platform/x86/Kconfig                  |  12 +
>   drivers/platform/x86/Makefile                 |   1 +
>   drivers/platform/x86/dell-wmi-sysman/Makefile |   8 +
>   .../x86/dell-wmi-sysman/biosattr-interface.c  | 199 ++++++
>   .../x86/dell-wmi-sysman/dell-wmi-sysman.h     | 195 ++++++
>   .../x86/dell-wmi-sysman/enum-attributes.c     | 188 ++++++
>   .../x86/dell-wmi-sysman/int-attributes.c      | 169 +++++
>   .../x86/dell-wmi-sysman/passobj-attributes.c  | 171 +++++
>   .../dell-wmi-sysman/passwordattr-interface.c  | 167 +++++
>   .../x86/dell-wmi-sysman/string-attributes.c   | 156 +++++
>   drivers/platform/x86/dell-wmi-sysman/sysman.c | 589 ++++++++++++++++++
>   13 files changed, 2082 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-firmware-attributes
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman/Makefile
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman/enum-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman/int-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman/string-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman/sysman.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> new file mode 100644
> index 000000000000..1228beeb8ff3
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -0,0 +1,219 @@
> +What:		/sys/class/firmware-attributes/*/attributes/*/
> +Date:		February 2021
> +KernelVersion:	5.11
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +Description:
> +		A sysfs interface for systems management software to enable
> +		configuration capability on supported systems.  This directory
> +		exposes interfaces for interacting with configuration options.
> +
> +		Unless otherwise specified in an attribute description all attributes are optional
> +		and will accept UTF-8 input.
> +
> +		type: A file that can be read to obtain the type of attribute.  This attribute is
> +			mandatory.
> +
> +		The following are known types:
> +			- enumeration: a set of pre-defined valid values
> +			- integer: a range of numerical values
> +			- string
> +
> +		All attribute types support the following values:
> +
> +		current_value:	A file that can be read to obtain the current
> +				value of the <attr>.
> +
> +				This file can also be written to in order to update the value of a
> +				<attr>
> +
> +				This attribute is mandatory.
> +
> +		default_value:	A file that can be read to obtain the default
> +				value of the <attr>
> +
> +		display_name:	A file that can be read to obtain a user friendly
> +				description of the at <attr>
> +
> +		display_name_language_code:	A file that can be read to obtain
> +						the IETF language tag corresponding to the
> +						"display_name" of the <attr>
> +
> +		"enumeration"-type specific properties:
> +
> +		possible_values:	A file that can be read to obtain the possible
> +					values of the <attr>. Values are separated using
> +					semi-colon (``;``).
> +
> +		"integer"-type specific properties:
> +
> +		min_value:	A file that can be read to obtain the lower
> +				bound value of the <attr>
> +
> +		max_value:	A file that can be read to obtain the upper
> +				bound value of the <attr>
> +
> +		scalar_increment:	A file that can be read to obtain the scalar value used for
> +					increments of current_value this attribute accepts.
> +
> +		"string"-type specific properties:
> +
> +		max_length:	A file that can be read to obtain the maximum
> +				length value of the <attr>
> +
> +		min_length:	A file that can be read to obtain the minimum
> +				length value of the <attr>
> +
> +		Dell specific class extensions
> +		--------------------------
> +
> +		On Dell systems the following additional attributes are available:
> +
> +		dell_modifier:	A file that can be read to obtain attribute-level
> +				dependency rule. It says an attribute X will become read-only or
> +				suppressed, if/if-not attribute Y is configured.
> +
> +				modifier rules can be in following format:
> +				[ReadOnlyIf:<attribute>=<value>]
> +				[ReadOnlyIfNot:<attribute>=<value>]
> +				[SuppressIf:<attribute>=<value>]
> +				[SuppressIfNot:<attribute>=<value>]
> +
> +				For example:
> +				AutoOnFri/dell_modifier has value,
> +					[SuppressIfNot:AutoOn=SelectDays]
> +
> +				This means AutoOnFri will be suppressed in BIOS setup if AutoOn
> +				attribute is not "SelectDays" and its value will not be effective
> +				through sysfs until this rule is met.
> +
> +		Enumeration attributes also support the following:
> +
> +		dell_value_modifier:	A file that can be read to obtain value-level dependency.
> +					This file is similar to dell_modifier but here,	an
> +					attribute's current value will be forcefully changed based
> +					dependent attributes value.
> +
> +					dell_value_modifier rules can be in following format:
> +					<value>[ForceIf:<attribute>=<value>]
> +					<value>[ForceIfNot:<attribute>=<value>]
> +
> +					For example,
> +					LegacyOrom/dell_value_modifier has value:
> +						Disabled[ForceIf:SecureBoot=Enabled]
> +					This means LegacyOrom's current value will be forced to
> +					"Disabled" in BIOS setup if SecureBoot is Enabled and its
> +					value will not be effective through sysfs until this rule is
> +					met.
> +
> +What:		/sys/class/firmware-attributes/*/authentication/
> +Date:		February 2021
> +KernelVersion:	5.11
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +
> +		Devices support various authentication mechanisms which can be exposed
> +		as a separate configuration object.
> +
> +		For example a "BIOS Admin" password and "System" Password can be set,
> +		reset or cleared using these attributes.
> +		- An "Admin" password is used for preventing modification to the BIOS
> +		  settings.
> +		- A "System" password is required to boot a machine.
> +
> +		Change in any of these two authentication methods will also generate an
> +		uevent KOBJ_CHANGE.
> +
> +		is_enabled:	A file that can be read to obtain a0/1 flag to see if <attr>
> +				authentication is enabled.
> +
> +		role:	The type of authentication used.
> +			Known types:
> +				bios-admin: Representing a BIOS administrator password
> +				power-on: Representing a password required to use the system
> +
> +		mechanism:	The means of authentication.
> +				Only supported type currently is "password".
> +
> +		max_password_length:	A file that can be read to obtain the
> +					maximum length of the Password
> +
> +		min_password_length:	A file that can be read to obtain the
> +					minimum length of the Password
> +
> +		current_password:	A write only value used for privileged access such as
> +					setting	attributes when a system or admin password is set
> +					or resetting to a new password
> +
> +		new_password:		A write only value that when used in tandem with
> +					current_password will reset a system or admin password.
> +
> +		Note, password management is session specific. If Admin password is set,
> +		same password must be written into current_password file (required for
> +		password-validation) and must be cleared once the session is over.
> +		For example:
> +			echo "password" > current_password
> +			echo "disabled" > TouchScreen/current_value
> +			echo "" > current_password
> +
> +		Drivers may emit a CHANGE uevent when a password is set or unset
> +		userspace may check it again.
> +
> +		On Dell systems, if Admin password is set, then all BIOS attributes
> +		require password validation.
> +
> +What:		/sys/class/firmware-attributes/*/attributes/pending_reboot
> +Date:		February 2021
> +KernelVersion:	5.11
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +Description:
> +		A read-only attribute reads 1 if a reboot is necessary to apply
> +		pending BIOS attribute changes. Also, an uevent_KOBJ_CHANGE is
> +		generated when it changes to 1.
> +
> +			0:	All BIOS attributes setting are current
> +			1:	A reboot is necessary to get pending BIOS attribute changes
> +				applied
> +
> +		Note, userspace applications need to follow below steps for efficient
> +		BIOS management,
> +		1.	Check if admin password is set. If yes, follow session method for
> +			password management as briefed under authentication section above.
> +		2.	Before setting any attribute, check if it has any modifiers
> +			or value_modifiers. If yes, incorporate them and then modify
> +			attribute.
> +
> +		Drivers may emit a CHANGE uevent when this value changes and userspace
> +		may check it again.
> +
> +What:		/sys/class/firmware-attributes/*/attributes/reset_bios
> +Date:		February 2021
> +KernelVersion:	5.11
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
> +		# echo "factory" > /sys/class/firmware-attributes/*/device/attributes/reset_bios
> +		# cat /sys/class/firmware-attributes/*/device/attributes/reset_bios
> +		# builtinsafe lastknowngood [factory] custom
> +
> +		Note that any changes to this attribute requires a reboot
> +		for changes to take effect.

The sysfs interface looks great to me now, many thanks!

Unfortunately a pdx86 related kernel regression was reported today,
so I will be busy the rest of the day taking care of that.

I will try to do a full code-review of this tomorrow.

Regards,

Hans




> diff --git a/MAINTAINERS b/MAINTAINERS
> index 190c7fa2ea01..264c8e12fc61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4951,6 +4951,14 @@ M:	Mario Limonciello <mario.limonciello@dell.com>
>   S:	Maintained
>   F:	drivers/platform/x86/dell-wmi-descriptor.c
>   
> +DELL WMI SYSMAN DRIVER
> +M:	Divya Bharathi <divya.bharathi@dell.com>
> +M:	Mario Limonciello <mario.limonciello@dell.com>
> +M:	Prasanth Ksr <prasanth.ksr@dell.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/dell-wmi-syman/*
> +
>   DELL WMI NOTIFICATIONS DRIVER
>   M:	Matthew Garrett <mjg59@srcf.ucam.org>
>   M:	Pali Rohár <pali@kernel.org>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 40219bba6801..190461cfc5da 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -430,6 +430,18 @@ config DELL_WMI
>   	  To compile this driver as a module, choose M here: the module will
>   	  be called dell-wmi.
>   
> +config DELL_WMI_SYSMAN
> +	tristate "Dell WMI-based Systems management driver"
> +	depends on ACPI_WMI
> +	depends on DMI
> +	select NLS
> +	help
> +	  This driver allows changing BIOS settings on many Dell machines from
> +	  2018 and newer without the use of any additional software.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called dell-wmi-sysman.
> +
>   config DELL_WMI_DESCRIPTOR
>   	tristate
>   	depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 5f823f7eff45..36ce38e80c8f 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_DELL_WMI)			+= dell-wmi.o
>   obj-$(CONFIG_DELL_WMI_DESCRIPTOR)	+= dell-wmi-descriptor.o
>   obj-$(CONFIG_DELL_WMI_AIO)		+= dell-wmi-aio.o
>   obj-$(CONFIG_DELL_WMI_LED)		+= dell-wmi-led.o
> +obj-$(CONFIG_DELL_WMI_SYSMAN)		+= dell-wmi-sysman/
>   
>   # Fujitsu
>   obj-$(CONFIG_AMILO_RFKILL)	+= amilo-rfkill.o
> diff --git a/drivers/platform/x86/dell-wmi-sysman/Makefile b/drivers/platform/x86/dell-wmi-sysman/Makefile
> new file mode 100644
> index 000000000000..825fb2fbeea8
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/Makefile
> @@ -0,0 +1,8 @@
> +obj-$(CONFIG_DELL_WMI_SYSMAN)  += dell-wmi-sysman.o
> +dell-wmi-sysman-objs := 	sysman.o		\
> +				enum-attributes.o	\
> +				int-attributes.o	\
> +				string-attributes.o	\
> +				passobj-attributes.o	\
> +				biosattr-interface.o	\
> +				passwordattr-interface.o
> diff --git a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
> new file mode 100644
> index 000000000000..820c05d0fb8c
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to SET methods under BIOS attributes interface GUID for use
> + * with dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include <linux/nls.h>
> +#include <linux/wmi.h>
> +#include "dell-wmi-sysman.h"
> +
> +#define SETDEFAULTVALUES_METHOD_ID					0x02
> +#define SETBIOSDEFAULTS_METHOD_ID					0x03
> +#define SETATTRIBUTE_METHOD_ID						0x04
> +
> +static int call_biosattributes_interface(struct wmi_device *wdev, char *in_args, size_t size,
> +					int method_id)
> +{
> +	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> +	struct acpi_buffer input;
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int ret = -EIO;
> +
> +	input.length =  (acpi_size) size;
> +	input.pointer = in_args;
> +	status = wmidev_evaluate_method(wdev, 0, method_id, &input, &output);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +	obj = (union acpi_object *)output.pointer;
> +	if (obj->type == ACPI_TYPE_INTEGER)
> +		ret = obj->integer.value;
> +
> +	if (wmi_priv.pending_changes == 0) {
> +		wmi_priv.pending_changes = 1;
> +		/* let userland know it may need to check reboot pending again */
> +		kobject_uevent(&wdev->dev.kobj, KOBJ_CHANGE);
> +	}
> +	kfree(output.pointer);
> +	return map_wmi_error(ret);
> +}
> +
> +/**
> + * set_attribute() - Update an attribute value
> + * @a_name: The attribute name
> + * @a_value: The attribute value
> + *
> + * Sets an attribute to new value
> + **/
> +int set_attribute(const char *a_name, const char *a_value)
> +{
> +	size_t security_area_size, string_area_size, buffer_size;
> +	char *attribute_name, *attribute_value;
> +	u8 *name_len, *value_len;
> +	char *buffer = NULL;
> +	int ret;
> +
> +	mutex_lock(&wmi_priv.mutex);
> +	if (!wmi_priv.bios_attr_wdev) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	/* build/calculate buffer */
> +	security_area_size = calculate_security_buffer();
> +	string_area_size = (strlen(a_name) + strlen(a_value))*2;
> +	buffer_size = security_area_size + string_area_size + sizeof(u16) * 2;
> +	buffer = kzalloc(buffer_size, GFP_KERNEL);
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* build security area */
> +	if (strlen(wmi_priv.current_admin_password) > 0)
> +		populate_security_buffer(buffer, wmi_priv.current_admin_password);
> +
> +	/* build variables to set */
> +	name_len = buffer + security_area_size;
> +	attribute_name = name_len + sizeof(u16);
> +	*name_len = utf8s_to_utf16s(a_name, strlen(a_name), UTF16_HOST_ENDIAN,
> +				    (wchar_t *) attribute_name, MAX_BUFF) * 2;
> +	if (*name_len < 0) {
> +		ret = -EINVAL;
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "UTF16 conversion failed\n");
> +		goto out;
> +	}
> +
> +	value_len = (u8 *) attribute_name + *name_len;
> +	attribute_value = value_len + sizeof(u16);
> +	*value_len = utf8s_to_utf16s(a_value, strlen(a_value), UTF16_HOST_ENDIAN,
> +				    (wchar_t *) attribute_value, MAX_BUFF) * 2;
> +	if (*value_len < 0) {
> +		ret = -EINVAL;
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "UTF16 conversion failed\n");
> +		goto out;
> +	}
> +
> +	ret = call_biosattributes_interface(wmi_priv.bios_attr_wdev,
> +					    buffer, buffer_size,
> +					    SETATTRIBUTE_METHOD_ID);
> +	if (ret == -EOPNOTSUPP)
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "admin password must be configured\n");
> +	else if (ret == -EACCES)
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "invalid password\n");
> +
> +out:
> +	kfree(buffer);
> +	mutex_unlock(&wmi_priv.mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * set_bios_defaults() - Resets BIOS defaults
> + * @deftype: the type of BIOS value reset to issue.
> + *
> + * Resets BIOS defaults
> + **/
> +int set_bios_defaults(u8 deftype)
> +{
> +	size_t security_area_size, buffer_size;
> +	size_t integer_area_size = sizeof(u8);
> +	char *buffer = NULL;
> +	u8 *defaultType;
> +	int ret;
> +
> +	mutex_lock(&wmi_priv.mutex);
> +	if (!wmi_priv.bios_attr_wdev) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	security_area_size = calculate_security_buffer();
> +	buffer_size = security_area_size + integer_area_size;
> +	buffer = kzalloc(buffer_size, GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	/* build security area */
> +	if (strlen(wmi_priv.current_admin_password) > 0)
> +		populate_security_buffer(buffer, wmi_priv.current_admin_password);
> +
> +	defaultType = buffer + security_area_size;
> +	*defaultType = deftype;
> +
> +	ret = call_biosattributes_interface(wmi_priv.bios_attr_wdev, buffer, buffer_size,
> +					    SETBIOSDEFAULTS_METHOD_ID);
> +	if (ret)
> +		dev_err(&wmi_priv.bios_attr_wdev->dev, "reset BIOS defaults failed: %d\n", ret);
> +
> +out:
> +	kfree(buffer);
> +	mutex_unlock(&wmi_priv.mutex);
> +
> +	return ret;
> +}
> +
> +static int bios_attr_set_interface_probe(struct wmi_device *wdev, const void *context)
> +{
> +	mutex_lock(&wmi_priv.mutex);
> +	wmi_priv.bios_attr_wdev = wdev;
> +	mutex_unlock(&wmi_priv.mutex);
> +	return 0;
> +}
> +
> +static int bios_attr_set_interface_remove(struct wmi_device *wdev)
> +{
> +	mutex_lock(&wmi_priv.mutex);
> +	wmi_priv.bios_attr_wdev = NULL;
> +	mutex_unlock(&wmi_priv.mutex);
> +	return 0;
> +}
> +
> +static const struct wmi_device_id bios_attr_set_interface_id_table[] = {
> +	{ .guid_string = DELL_WMI_BIOS_ATTRIBUTES_INTERFACE_GUID },
> +	{ },
> +};
> +static struct wmi_driver bios_attr_set_interface_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME
> +	},
> +	.probe = bios_attr_set_interface_probe,
> +	.remove = bios_attr_set_interface_remove,
> +	.id_table = bios_attr_set_interface_id_table,
> +};
> +
> +int init_bios_attr_set_interface(void)
> +{
> +	return wmi_driver_register(&bios_attr_set_interface_driver);
> +}
> +
> +void exit_bios_attr_set_interface(void)
> +{
> +	wmi_driver_unregister(&bios_attr_set_interface_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(wmi, bios_attr_set_interface_id_table);
> diff --git a/drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h b/drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h
> new file mode 100644
> index 000000000000..5074592dbfc4
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h
> @@ -0,0 +1,195 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * Definitions for kernel modules using Dell WMI System Management Driver
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#ifndef _DELL_WMI_BIOS_ATTR_H_
> +#define _DELL_WMI_BIOS_ATTR_H_
> +
> +#include <linux/wmi.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/capability.h>
> +
> +#define DRIVER_NAME					"dell-wmi-sysman"
> +#define MAX_BUFF  512
> +
> +#define DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID	"F1DDEE52-063C-4784-A11E-8A06684B9BF5"
> +#define DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID		"F1DDEE52-063C-4784-A11E-8A06684B9BFA"
> +#define DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID		"F1DDEE52-063C-4784-A11E-8A06684B9BF9"
> +#define DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID		"0894B8D6-44A6-4719-97D7-6AD24108BFD4"
> +#define DELL_WMI_BIOS_ATTRIBUTES_INTERFACE_GUID		"F1DDEE52-063C-4784-A11E-8A06684B9BF4"
> +#define DELL_WMI_BIOS_PASSWORD_INTERFACE_GUID		"70FE8229-D03B-4214-A1C6-1F884B1A892A"
> +
> +struct enumeration_data {
> +	struct kobject *attr_name_kobj;
> +	char display_name_language_code[MAX_BUFF];
> +	char attribute_name[MAX_BUFF];
> +	char display_name[MAX_BUFF];
> +	char default_value[MAX_BUFF];
> +	char current_value[MAX_BUFF];
> +	char dell_modifier[MAX_BUFF];
> +	int value_modifier_count;
> +	char dell_value_modifier[MAX_BUFF];
> +	int possible_values_count;
> +	char possible_values[MAX_BUFF];
> +	char type[MAX_BUFF];
> +};
> +
> +struct integer_data {
> +	struct kobject *attr_name_kobj;
> +	char display_name_language_code[MAX_BUFF];
> +	char attribute_name[MAX_BUFF];
> +	char display_name[MAX_BUFF];
> +	int default_value;
> +	int current_value;
> +	char dell_modifier[MAX_BUFF];
> +	int min_value;
> +	int max_value;
> +	int scalar_increment;
> +	char type[MAX_BUFF];
> +};
> +
> +struct str_data {
> +	struct kobject *attr_name_kobj;
> +	char display_name_language_code[MAX_BUFF];
> +	char attribute_name[MAX_BUFF];
> +	char display_name[MAX_BUFF];
> +	char default_value[MAX_BUFF];
> +	char current_value[MAX_BUFF];
> +	char dell_modifier[MAX_BUFF];
> +	int min_length;
> +	int max_length;
> +	char type[MAX_BUFF];
> +};
> +
> +struct po_data {
> +	struct kobject *attr_name_kobj;
> +	char attribute_name[MAX_BUFF];
> +	int is_enabled;
> +	int min_password_length;
> +	int max_password_length;
> +};
> +
> +struct wmi_sysman_priv {
> +	char current_admin_password[MAX_BUFF];
> +	char current_system_password[MAX_BUFF];
> +	struct wmi_device *password_attr_wdev;
> +	struct wmi_device *bios_attr_wdev;
> +	struct kset *authentication_dir_kset;
> +	struct kset *main_dir_kset;
> +	struct enumeration_data *enumeration_data;
> +	int enumeration_instances_count;
> +	struct integer_data *integer_data;
> +	int integer_instances_count;
> +	struct str_data *str_data;
> +	int str_instances_count;
> +	struct po_data *po_data;
> +	int po_instances_count;
> +	bool pending_changes;
> +	struct mutex mutex;
> +};
> +
> +/* global structure used by multiple WMI interfaces */
> +extern struct wmi_sysman_priv wmi_priv;
> +
> +enum { ENUM, INT, STR, PO };
> +
> +enum {
> +	ATTR_NAME,
> +	DISPL_NAME_LANG_CODE,
> +	DISPLAY_NAME,
> +	DEFAULT_VAL,
> +	CURRENT_VAL,
> +	MODIFIER
> +};
> +
> +#define get_instance_id(type)							\
> +int get_##type##_instance_id(struct kobject *kobj);				\
> +int get_##type##_instance_id(struct kobject *kobj)				\
> +{										\
> +	int i;									\
> +	for (i = 0; i <= wmi_priv.type##_instances_count; i++) {		\
> +		if (!(strcmp(kobj->name, wmi_priv.type##_data[i].attribute_name)))\
> +			return i;						\
> +	}									\
> +	return -EIO;								\
> +}
> +
> +#define attribute_s_property_show(name, type)					\
> +static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr,	\
> +			   char *buf)						\
> +{										\
> +	int i = get_##type##_instance_id(kobj);					\
> +	if (i >= 0)								\
> +		return sprintf(buf, "%s\n", wmi_priv.type##_data[i].name);	\
> +	return 0;								\
> +}
> +
> +#define attribute_n_property_show(name, type)					\
> +static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr,	\
> +			   char *buf)						\
> +{										\
> +	int i = get_##type##_instance_id(kobj);					\
> +	if (i >= 0)								\
> +		return sprintf(buf, "%d\n", wmi_priv.type##_data[i].name);	\
> +	return 0;								\
> +}
> +
> +#define attribute_property_store(curr_val, type)				\
> +static ssize_t curr_val##_store(struct kobject *kobj,				\
> +				struct kobj_attribute *attr,			\
> +				const char *buf, size_t count)			\
> +{										\
> +	char *p = memchr(buf, '\n', count);					\
> +	int ret = -EIO;								\
> +	int i;									\
> +										\
> +	if (p != NULL)								\
> +		*p = '\0';							\
> +	i = get_##type##_instance_id(kobj);					\
> +	if (i >= 0)								\
> +		ret = validate_##type##_input(i, buf);				\
> +	if (!ret)								\
> +		ret = set_attribute(kobj->name, buf);				\
> +	return ret ? ret : count;						\
> +}
> +
> +union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid_string);
> +int get_instance_count(const char *guid_string);
> +void strlcpy_attr(char *dest, char *src);
> +
> +int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
> +			struct kobject *attr_name_kobj);
> +int alloc_enum_data(void);
> +void exit_enum_attributes(void);
> +
> +int populate_int_data(union acpi_object *integer_obj, int instance_id,
> +			struct kobject *attr_name_kobj);
> +int alloc_int_data(void);
> +void exit_int_attributes(void);
> +
> +int populate_str_data(union acpi_object *str_obj, int instance_id, struct kobject *attr_name_kobj);
> +int alloc_str_data(void);
> +void exit_str_attributes(void);
> +
> +int populate_po_data(union acpi_object *po_obj, int instance_id, struct kobject *attr_name_kobj);
> +int alloc_po_data(void);
> +void exit_po_attributes(void);
> +
> +int set_attribute(const char *a_name, const char *a_value);
> +int set_bios_defaults(u8 defType);
> +
> +void exit_bios_attr_set_interface(void);
> +int init_bios_attr_set_interface(void);
> +int map_wmi_error(int error_code);
> +size_t calculate_security_buffer(void);
> +void populate_security_buffer(char *buffer, char *authentication);
> +
> +int set_new_password(const char *password_type, const char *new);
> +int init_bios_attr_pass_interface(void);
> +void exit_bios_attr_pass_interface(void);
> +
> +#endif
> diff --git a/drivers/platform/x86/dell-wmi-sysman/enum-attributes.c b/drivers/platform/x86/dell-wmi-sysman/enum-attributes.c
> new file mode 100644
> index 000000000000..cfcb226db634
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/enum-attributes.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to enumeration type attributes under BIOS Enumeration GUID for use
> + * with dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include "dell-wmi-sysman.h"
> +
> +get_instance_id(enumeration);
> +
> +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int instance_id;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +	instance_id = get_enumeration_instance_id(kobj);
> +	if (instance_id >= 0) {
> +		union acpi_object *obj;
> +
> +		/* need to use specific instance_id and guid combination to get right data */
> +		obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
> +		if (!obj)
> +			return -AE_ERROR;
> +		strlcpy_attr(wmi_priv.enumeration_data[instance_id].current_value,
> +		       obj->package.elements[CURRENT_VAL].string.pointer);
> +		kfree(obj);
> +		return sprintf(buf, "%s\n", wmi_priv.enumeration_data[instance_id].current_value);
> +	}
> +	return -EIO;
> +}
> +
> +/**
> + * validate_enumeration_input() - Validate input of current_value against possible values
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + **/
> +static int validate_enumeration_input(int instance_id, const char *buf)
> +{
> +	char *options, *tmp, *p;
> +	int ret = -EINVAL;
> +
> +	options = tmp = kstrdup(wmi_priv.enumeration_data[instance_id].possible_values,
> +				 GFP_KERNEL);
> +	if (!options)
> +		return -ENOMEM;
> +
> +	while ((p = strsep(&options, ";")) != NULL) {
> +		if (!*p)
> +			continue;
> +		if (!strncasecmp(p, buf, strlen(p))) {
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	kfree(tmp);
> +	return ret;
> +}
> +
> +attribute_s_property_show(display_name_language_code, enumeration);
> +static struct kobj_attribute displ_langcode =
> +		__ATTR_RO(display_name_language_code);
> +
> +attribute_s_property_show(display_name, enumeration);
> +static struct kobj_attribute displ_name =
> +		__ATTR_RO(display_name);
> +
> +attribute_s_property_show(default_value, enumeration);
> +static struct kobj_attribute default_val =
> +		__ATTR_RO(default_value);
> +
> +attribute_property_store(current_value, enumeration);
> +static struct kobj_attribute current_val =
> +		__ATTR_RW(current_value);
> +
> +attribute_s_property_show(dell_modifier, enumeration);
> +static struct kobj_attribute modifier =
> +		__ATTR_RO(dell_modifier);
> +
> +attribute_s_property_show(dell_value_modifier, enumeration);
> +static struct kobj_attribute value_modfr =
> +		__ATTR_RO(dell_value_modifier);
> +
> +attribute_s_property_show(possible_values, enumeration);
> +static struct kobj_attribute poss_val =
> +		__ATTR_RO(possible_values);
> +
> +attribute_s_property_show(type, enumeration);
> +static struct kobj_attribute type =
> +		__ATTR_RO(type);
> +
> +static struct attribute *enumeration_attrs[] = {
> +	&displ_langcode.attr,
> +	&displ_name.attr,
> +	&default_val.attr,
> +	&current_val.attr,
> +	&modifier.attr,
> +	&value_modfr.attr,
> +	&poss_val.attr,
> +	&type.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group enumeration_attr_group = {
> +	.attrs = enumeration_attrs,
> +};
> +
> +int alloc_enum_data(void)
> +{
> +	int ret = 0;
> +
> +	wmi_priv.enumeration_instances_count =
> +		get_instance_count(DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
> +	wmi_priv.enumeration_data = kcalloc(wmi_priv.enumeration_instances_count,
> +					sizeof(struct enumeration_data), GFP_KERNEL);
> +	if (!wmi_priv.enumeration_data)
> +		ret = -ENOMEM;
> +	return ret;
> +}
> +
> +/**
> + * populate_enum_data() - Populate all properties of an instance under enumeration attribute
> + * @enumeration_obj: ACPI object with enumeration data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + **/
> +int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
> +			struct kobject *attr_name_kobj)
> +{
> +	int i, next_obj;
> +
> +	wmi_priv.enumeration_data[instance_id].attr_name_kobj = attr_name_kobj;
> +	strlcpy_attr(wmi_priv.enumeration_data[instance_id].attribute_name,
> +		enumeration_obj[ATTR_NAME].string.pointer);
> +	strlcpy_attr(wmi_priv.enumeration_data[instance_id].display_name_language_code,
> +		enumeration_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	strlcpy_attr(wmi_priv.enumeration_data[instance_id].display_name,
> +		enumeration_obj[DISPLAY_NAME].string.pointer);
> +	strlcpy_attr(wmi_priv.enumeration_data[instance_id].default_value,
> +		enumeration_obj[DEFAULT_VAL].string.pointer);
> +	strlcpy_attr(wmi_priv.enumeration_data[instance_id].current_value,
> +		enumeration_obj[CURRENT_VAL].string.pointer);
> +	strlcpy_attr(wmi_priv.enumeration_data[instance_id].dell_modifier,
> +		enumeration_obj[MODIFIER].string.pointer);
> +
> +	next_obj = MODIFIER + 1;
> +
> +	wmi_priv.enumeration_data[instance_id].value_modifier_count =
> +		(uintptr_t)enumeration_obj[next_obj].string.pointer;
> +
> +	for (i = 0; i < wmi_priv.enumeration_data[instance_id].value_modifier_count; i++) {
> +		strcat(wmi_priv.enumeration_data[instance_id].dell_value_modifier,
> +			enumeration_obj[++next_obj].string.pointer);
> +		strcat(wmi_priv.enumeration_data[instance_id].dell_value_modifier, ";");
> +	}
> +
> +	wmi_priv.enumeration_data[instance_id].possible_values_count =
> +		(uintptr_t) enumeration_obj[++next_obj].string.pointer;
> +
> +	for (i = 0; i < wmi_priv.enumeration_data[instance_id].possible_values_count; i++) {
> +		strcat(wmi_priv.enumeration_data[instance_id].possible_values,
> +			enumeration_obj[++next_obj].string.pointer);
> +		strcat(wmi_priv.enumeration_data[instance_id].possible_values, ";");
> +	}
> +	strlcpy_attr(wmi_priv.enumeration_data[instance_id].type, "enumeration");
> +
> +	return sysfs_create_group(attr_name_kobj, &enumeration_attr_group);
> +}
> +
> +/**
> + * exit_enum_attributes() - Clear all attribute data
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_enum_attributes(void)
> +{
> +	int instance_id;
> +
> +	for (instance_id = 0; instance_id < wmi_priv.enumeration_instances_count; instance_id++) {
> +		if (wmi_priv.enumeration_data[instance_id].attr_name_kobj)
> +			sysfs_remove_group(wmi_priv.enumeration_data[instance_id].attr_name_kobj,
> +								&enumeration_attr_group);
> +	}
> +	kfree(wmi_priv.enumeration_data);
> +}
> diff --git a/drivers/platform/x86/dell-wmi-sysman/int-attributes.c b/drivers/platform/x86/dell-wmi-sysman/int-attributes.c
> new file mode 100644
> index 000000000000..f668d69eaf09
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/int-attributes.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to integer type attributes under BIOS Integer GUID for use with
> + * dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include "dell-wmi-sysman.h"
> +
> +enum int_properties {MIN_VALUE = 6, MAX_VALUE, SCALAR_INCR};
> +
> +get_instance_id(integer);
> +
> +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int instance_id;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +	instance_id = get_integer_instance_id(kobj);
> +	if (instance_id >= 0) {
> +		union acpi_object *obj;
> +
> +		/* need to use specific instance_id and guid combination to get right data */
> +		obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
> +		if (!obj)
> +			return -AE_ERROR;
> +		wmi_priv.integer_data[instance_id].current_value =
> +			(uintptr_t)obj->package.elements[CURRENT_VAL].string.pointer;
> +		kfree(obj);
> +		return sprintf(buf, "%d\n", wmi_priv.integer_data[instance_id].current_value);
> +	}
> +	return -EIO;
> +}
> +
> +/**
> + * validate_integer_input() - Validate input of current_value against lower and upper bound
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + **/
> +static int validate_integer_input(int instance_id, const char *buf)
> +{
> +	int ret = -EINVAL;
> +	int in_val;
> +
> +	if (kstrtoint(buf, 0, &in_val))
> +		return ret;
> +	if ((in_val >= wmi_priv.integer_data[instance_id].min_value) &&
> +	(in_val <= wmi_priv.integer_data[instance_id].max_value))
> +		ret = 0;
> +
> +	return ret;
> +}
> +
> +attribute_s_property_show(display_name_language_code, integer);
> +static struct kobj_attribute integer_displ_langcode =
> +	__ATTR_RO(display_name_language_code);
> +
> +attribute_s_property_show(display_name, integer);
> +static struct kobj_attribute integer_displ_name =
> +	__ATTR_RO(display_name);
> +
> +attribute_n_property_show(default_value, integer);
> +static struct kobj_attribute integer_default_val =
> +	__ATTR_RO(default_value);
> +
> +attribute_property_store(current_value, integer);
> +static struct kobj_attribute integer_current_val =
> +	__ATTR_RW(current_value);
> +
> +attribute_s_property_show(dell_modifier, integer);
> +static struct kobj_attribute integer_modifier =
> +	__ATTR_RO(dell_modifier);
> +
> +attribute_n_property_show(min_value, integer);
> +static struct kobj_attribute integer_lower_bound =
> +	__ATTR_RO(min_value);
> +
> +attribute_n_property_show(max_value, integer);
> +static struct kobj_attribute integer_upper_bound =
> +	__ATTR_RO(max_value);
> +
> +attribute_n_property_show(scalar_increment, integer);
> +static struct kobj_attribute integer_scalar_increment =
> +	__ATTR_RO(scalar_increment);
> +
> +attribute_s_property_show(type, integer);
> +static struct kobj_attribute integer_type =
> +	__ATTR_RO(type);
> +
> +static struct attribute *integer_attrs[] = {
> +	&integer_displ_langcode.attr,
> +	&integer_displ_name.attr,
> +	&integer_default_val.attr,
> +	&integer_current_val.attr,
> +	&integer_modifier.attr,
> +	&integer_lower_bound.attr,
> +	&integer_upper_bound.attr,
> +	&integer_scalar_increment.attr,
> +	&integer_type.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group integer_attr_group = {
> +	.attrs = integer_attrs,
> +};
> +
> +int alloc_int_data(void)
> +{
> +	int ret = 0;
> +
> +	wmi_priv.integer_instances_count = get_instance_count(DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
> +	wmi_priv.integer_data = kcalloc(wmi_priv.integer_instances_count,
> +					sizeof(struct integer_data), GFP_KERNEL);
> +	if (!wmi_priv.integer_data)
> +		ret = -ENOMEM;
> +	return ret;
> +}
> +
> +/**
> + * populate_int_data() - Populate all properties of an instance under integer attribute
> + * @integer_obj: ACPI object with integer data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + **/
> +int populate_int_data(union acpi_object *integer_obj, int instance_id,
> +			struct kobject *attr_name_kobj)
> +{
> +	wmi_priv.integer_data[instance_id].attr_name_kobj = attr_name_kobj;
> +	strlcpy_attr(wmi_priv.integer_data[instance_id].attribute_name,
> +		integer_obj[ATTR_NAME].string.pointer);
> +	strlcpy_attr(wmi_priv.integer_data[instance_id].display_name_language_code,
> +		integer_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	strlcpy_attr(wmi_priv.integer_data[instance_id].display_name,
> +		integer_obj[DISPLAY_NAME].string.pointer);
> +	wmi_priv.integer_data[instance_id].default_value =
> +		(uintptr_t)integer_obj[DEFAULT_VAL].string.pointer;
> +	wmi_priv.integer_data[instance_id].current_value =
> +		(uintptr_t)integer_obj[CURRENT_VAL].string.pointer;
> +	strlcpy_attr(wmi_priv.integer_data[instance_id].dell_modifier,
> +		integer_obj[MODIFIER].string.pointer);
> +	wmi_priv.integer_data[instance_id].min_value =
> +		(uintptr_t)integer_obj[MIN_VALUE].string.pointer;
> +	wmi_priv.integer_data[instance_id].max_value =
> +		(uintptr_t)integer_obj[MAX_VALUE].string.pointer;
> +	wmi_priv.integer_data[instance_id].scalar_increment =
> +		(uintptr_t)integer_obj[SCALAR_INCR].string.pointer;
> +	strlcpy_attr(wmi_priv.integer_data[instance_id].type, "integer");
> +
> +	return sysfs_create_group(attr_name_kobj, &integer_attr_group);
> +}
> +
> +/**
> + * exit_int_attributes() - Clear all attribute data
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_int_attributes(void)
> +{
> +	int instance_id;
> +
> +	for (instance_id = 0; instance_id < wmi_priv.integer_instances_count; instance_id++) {
> +		if (wmi_priv.integer_data[instance_id].attr_name_kobj)
> +			sysfs_remove_group(wmi_priv.integer_data[instance_id].attr_name_kobj,
> +								&integer_attr_group);
> +	}
> +	kfree(wmi_priv.integer_data);
> +}
> diff --git a/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
> new file mode 100644
> index 000000000000..9c56718afd06
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to password object type attributes under BIOS Password Object GUID for
> + * use with dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include "dell-wmi-sysman.h"
> +
> +enum po_properties {IS_PASS_SET = 1, MIN_PASS_LEN, MAX_PASS_LEN};
> +
> +get_instance_id(po);
> +
> +static ssize_t is_enabled_show(struct kobject *kobj, struct kobj_attribute *attr,
> +					  char *buf)
> +{
> +	int instance_id = get_po_instance_id(kobj);
> +
> +	if (instance_id >= 0) {
> +		union acpi_object *obj;
> +
> +		/* need to use specific instance_id and guid combination to get right data */
> +		obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID);
> +		if (!obj)
> +			return -AE_ERROR;
> +		wmi_priv.po_data[instance_id].is_enabled =
> +			(uintptr_t)obj->package.elements[IS_PASS_SET].string.pointer;
> +		kfree(obj);
> +		return sprintf(buf, "%d\n", wmi_priv.po_data[instance_id].is_enabled);
> +	}
> +	return -EIO;
> +}
> +
> +struct kobj_attribute po_is_pass_set =
> +		__ATTR_RO(is_enabled);
> +
> +static ssize_t current_password_store(struct kobject *kobj,
> +				      struct kobj_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	char *p = memchr(buf, '\n', count);
> +	int ret;
> +
> +	if (p != NULL)
> +		*p = '\0';
> +	if (strlen(buf) >= MAX_BUFF)
> +		return -EINVAL;
> +
> +	if (strcmp(kobj->name, "Admin") == 0)
> +		memcpy(wmi_priv.current_admin_password, buf, (strlen(buf) + 1));
> +	if (strcmp(kobj->name, "System") == 0)
> +		memcpy(wmi_priv.current_system_password, buf, (strlen(buf) + 1));
> +	return ret ? ret : count;
> +}
> +
> +struct kobj_attribute po_current_password =
> +		__ATTR_WO(current_password);
> +
> +static ssize_t new_password_store(struct kobject *kobj,
> +				  struct kobj_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	char *p = memchr(buf, '\n', count);
> +	int ret;
> +
> +	if (p != NULL)
> +		*p = '\0';
> +	if (strlen(buf) > MAX_BUFF)
> +		return -EINVAL;
> +
> +	ret = set_new_password(kobj->name, buf);
> +	return ret ? ret : count;
> +}
> +
> +struct kobj_attribute po_new_password =
> +		__ATTR_WO(new_password);
> +
> +attribute_n_property_show(min_password_length, po);
> +struct kobj_attribute po_min_pass_length =
> +		__ATTR_RO(min_password_length);
> +
> +attribute_n_property_show(max_password_length, po);
> +struct kobj_attribute po_max_pass_length =
> +		__ATTR_RO(max_password_length);
> +
> +static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	return sprintf(buf, "password\n");
> +}
> +
> +struct kobj_attribute po_mechanism =
> +	__ATTR_RO(mechanism);
> +
> +static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	if (strcmp(kobj->name, "Admin") == 0)
> +		return sprintf(buf, "bios-admin\n");
> +	else if (strcmp(kobj->name, "System") == 0)
> +		return sprintf(buf, "power-on\n");
> +	return -EIO;
> +}
> +
> +struct kobj_attribute po_role =
> +	__ATTR_RO(role);
> +
> +static struct attribute *po_attrs[] = {
> +	&po_is_pass_set.attr,
> +	&po_min_pass_length.attr,
> +	&po_max_pass_length.attr,
> +	&po_current_password.attr,
> +	&po_new_password.attr,
> +	&po_role.attr,
> +	&po_mechanism.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group po_attr_group = {
> +	.attrs = po_attrs,
> +};
> +
> +int alloc_po_data(void)
> +{
> +	int ret = 0;
> +
> +	wmi_priv.po_instances_count = get_instance_count(DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID);
> +	wmi_priv.po_data = kcalloc(wmi_priv.po_instances_count, sizeof(struct po_data), GFP_KERNEL);
> +	if (!wmi_priv.po_data)
> +		ret = -ENOMEM;
> +	return ret;
> +}
> +
> +/**
> + * populate_po_data() - Populate all properties of an instance under password object attribute
> + * @po_obj: ACPI object with password object data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + **/
> +int populate_po_data(union acpi_object *po_obj, int instance_id, struct kobject *attr_name_kobj)
> +{
> +	wmi_priv.po_data[instance_id].attr_name_kobj = attr_name_kobj;
> +	strlcpy_attr(wmi_priv.po_data[instance_id].attribute_name,
> +		     po_obj[ATTR_NAME].string.pointer);
> +	wmi_priv.po_data[instance_id].is_enabled =
> +		(uintptr_t)po_obj[IS_PASS_SET].string.pointer;
> +	wmi_priv.po_data[instance_id].min_password_length =
> +		(uintptr_t)po_obj[MIN_PASS_LEN].string.pointer;
> +	wmi_priv.po_data[instance_id].max_password_length =
> +		(uintptr_t) po_obj[MAX_PASS_LEN].string.pointer;
> +
> +	return sysfs_create_group(attr_name_kobj, &po_attr_group);
> +}
> +
> +/**
> + * exit_po_attributes() - Clear all attribute data
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_po_attributes(void)
> +{
> +	int instance_id;
> +
> +	for (instance_id = 0; instance_id < wmi_priv.po_instances_count; instance_id++) {
> +		if (wmi_priv.po_data[instance_id].attr_name_kobj)
> +			sysfs_remove_group(wmi_priv.po_data[instance_id].attr_name_kobj,
> +								&po_attr_group);
> +	}
> +	kfree(wmi_priv.po_data);
> +}
> diff --git a/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c b/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
> new file mode 100644
> index 000000000000..40854a2c09a8
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to SET password methods under BIOS attributes interface GUID
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include <linux/nls.h>
> +#include <linux/wmi.h>
> +#include "dell-wmi-sysman.h"
> +
> +static int call_password_interface(struct wmi_device *wdev, char *in_args, size_t size)
> +{
> +	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> +	struct acpi_buffer input;
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int ret = -EIO;
> +
> +	input.length =  (acpi_size) size;
> +	input.pointer = in_args;
> +	status = wmidev_evaluate_method(wdev, 0, 1, &input, &output);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +	obj = (union acpi_object *)output.pointer;
> +	if (obj->type == ACPI_TYPE_INTEGER)
> +		ret = obj->integer.value;
> +
> +	kfree(output.pointer);
> +	/* let userland know it may need to check is_password_set again */
> +	kobject_uevent(&wdev->dev.kobj, KOBJ_CHANGE);
> +	return map_wmi_error(ret);
> +}
> +
> +/**
> + * set_new_password() - Sets a system admin password
> + * @password_type: The type of password to set
> + * @new: The new password
> + *
> + * Sets the password using plaintext interface
> + **/
> +int set_new_password(const char *password_type, const char *new)
> +{
> +	char *current_password, *type_value, *old_value, *new_value;
> +	size_t security_area_size, string_area_size, buffer_size;
> +	u8 *type_len, *old_len, *new_len;
> +	char *buffer = NULL;
> +	int ret;
> +
> +	mutex_lock(&wmi_priv.mutex);
> +	if (!wmi_priv.password_attr_wdev) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +	if (strcmp(password_type, "Admin") == 0) {
> +		current_password = wmi_priv.current_admin_password;
> +	} else if (strcmp(password_type, "System") == 0) {
> +		current_password = wmi_priv.current_system_password;
> +	} else {
> +		ret = -EINVAL;
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "unknown password type %s\n",
> +			password_type);
> +		goto out;
> +	}
> +
> +	/* build/calculate buffer */
> +	security_area_size = calculate_security_buffer();
> +	string_area_size = (strlen(password_type) + strlen(current_password) + strlen(new))*2;
> +	buffer_size = security_area_size + string_area_size + sizeof(u16) * 3;
> +	buffer = kzalloc(buffer_size, GFP_KERNEL);
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* build security area */
> +	if (strlen(wmi_priv.current_admin_password) > 0)
> +		populate_security_buffer(buffer, wmi_priv.current_admin_password);
> +
> +	/* build variables to set */
> +	type_len = buffer + security_area_size;
> +	type_value = type_len + sizeof(u16);
> +	*type_len = utf8s_to_utf16s(password_type, strlen(password_type), UTF16_HOST_ENDIAN,
> +				    (wchar_t *) type_value, MAX_BUFF) * 2;
> +	if (*type_len < 0) {
> +		ret = -EINVAL;
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "UTF16 conversion failed\n");
> +		goto out;
> +	}
> +
> +	old_len = type_value + *type_len;
> +	old_value = old_len + sizeof(u16);
> +	*old_len = utf8s_to_utf16s(current_password, strlen(current_password), UTF16_HOST_ENDIAN,
> +				   (wchar_t *) old_value, MAX_BUFF) * 2;
> +	if (*old_len < 0) {
> +		ret = -EINVAL;
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "UTF16 conversion failed\n");
> +		goto out;
> +	}
> +
> +	new_len = old_value + *old_len;
> +	new_value = new_len + sizeof(u16);
> +	*new_len = utf8s_to_utf16s(new, strlen(new), UTF16_HOST_ENDIAN,
> +				   (wchar_t *) new_value, MAX_BUFF) * 2;
> +	if (*new_len < 0) {
> +		ret = -EINVAL;
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "UTF16 conversion failed\n");
> +		goto out;
> +	}
> +
> +	ret = call_password_interface(wmi_priv.password_attr_wdev, buffer, buffer_size);
> +	/* clear current_password here and use user input from wmi_priv.current_password */
> +	if (!ret)
> +		current_password = "";
> +	/* explain to user the detailed failure reason */
> +	else if (ret == -EOPNOTSUPP)
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "admin password must be configured\n");
> +	else if (ret == -EACCES)
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "invalid password\n");
> +
> +out:
> +	kfree(buffer);
> +	mutex_unlock(&wmi_priv.mutex);
> +
> +	return ret;
> +}
> +
> +static int bios_attr_pass_interface_probe(struct wmi_device *wdev, const void *context)
> +{
> +	mutex_lock(&wmi_priv.mutex);
> +	wmi_priv.password_attr_wdev = wdev;
> +	mutex_unlock(&wmi_priv.mutex);
> +	return 0;
> +}
> +
> +static int bios_attr_pass_interface_remove(struct wmi_device *wdev)
> +{
> +	mutex_lock(&wmi_priv.mutex);
> +	wmi_priv.password_attr_wdev = NULL;
> +	mutex_unlock(&wmi_priv.mutex);
> +	return 0;
> +}
> +
> +static const struct wmi_device_id bios_attr_pass_interface_id_table[] = {
> +	{ .guid_string = DELL_WMI_BIOS_PASSWORD_INTERFACE_GUID },
> +	{ },
> +};
> +static struct wmi_driver bios_attr_pass_interface_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME"-password"
> +	},
> +	.probe = bios_attr_pass_interface_probe,
> +	.remove = bios_attr_pass_interface_remove,
> +	.id_table = bios_attr_pass_interface_id_table,
> +};
> +
> +int init_bios_attr_pass_interface(void)
> +{
> +	return wmi_driver_register(&bios_attr_pass_interface_driver);
> +}
> +
> +void exit_bios_attr_pass_interface(void)
> +{
> +	wmi_driver_unregister(&bios_attr_pass_interface_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(wmi, bios_attr_pass_interface_id_table);
> diff --git a/drivers/platform/x86/dell-wmi-sysman/string-attributes.c b/drivers/platform/x86/dell-wmi-sysman/string-attributes.c
> new file mode 100644
> index 000000000000..6b9948157b8d
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/string-attributes.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to string type attributes under BIOS String GUID for use with
> + * dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include "dell-wmi-sysman.h"
> +
> +enum string_properties {MIN_LEN = 6, MAX_LEN};
> +
> +get_instance_id(str);
> +
> +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int instance_id;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +	instance_id = get_str_instance_id(kobj);
> +	if (instance_id >= 0) {
> +		union acpi_object *obj;
> +
> +		/* need to use specific instance_id and guid combination to get right data */
> +		obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
> +		if (!obj)
> +			return -AE_ERROR;
> +		strlcpy_attr(wmi_priv.str_data[instance_id].current_value,
> +			obj->package.elements[CURRENT_VAL].string.pointer);
> +		kfree(obj);
> +		return sprintf(buf, "%s\n", wmi_priv.str_data[instance_id].current_value);
> +	}
> +	return -EIO;
> +}
> +
> +/**
> + * validate_str_input() - Validate input of current_value against min and max lengths
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + **/
> +static int validate_str_input(int instance_id, const char *buf)
> +{
> +	int in_len = strlen(buf);
> +
> +	if ((in_len >= wmi_priv.str_data[instance_id].min_length) &&
> +	(in_len <= wmi_priv.str_data[instance_id].max_length))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +attribute_s_property_show(display_name_language_code, str);
> +static struct kobj_attribute str_displ_langcode =
> +		__ATTR_RO(display_name_language_code);
> +
> +attribute_s_property_show(display_name, str);
> +static struct kobj_attribute str_displ_name =
> +		__ATTR_RO(display_name);
> +
> +attribute_s_property_show(default_value, str);
> +static struct kobj_attribute str_default_val =
> +		__ATTR_RO(default_value);
> +
> +attribute_property_store(current_value, str);
> +static struct kobj_attribute str_current_val =
> +		__ATTR_RW(current_value);
> +
> +attribute_s_property_show(dell_modifier, str);
> +static struct kobj_attribute str_modifier =
> +		__ATTR_RO(dell_modifier);
> +
> +attribute_n_property_show(min_length, str);
> +static struct kobj_attribute str_min_length =
> +		__ATTR_RO(min_length);
> +
> +attribute_n_property_show(max_length, str);
> +static struct kobj_attribute str_max_length =
> +		__ATTR_RO(max_length);
> +
> +attribute_s_property_show(type, str);
> +static struct kobj_attribute str_type =
> +	__ATTR_RO(type);
> +
> +static struct attribute *str_attrs[] = {
> +	&str_displ_langcode.attr,
> +	&str_displ_name.attr,
> +	&str_default_val.attr,
> +	&str_current_val.attr,
> +	&str_modifier.attr,
> +	&str_min_length.attr,
> +	&str_max_length.attr,
> +	&str_type.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group str_attr_group = {
> +	.attrs = str_attrs,
> +};
> +
> +int alloc_str_data(void)
> +{
> +	int ret = 0;
> +
> +	wmi_priv.str_instances_count = get_instance_count(DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
> +	wmi_priv.str_data = kcalloc(wmi_priv.str_instances_count,
> +					sizeof(struct str_data), GFP_KERNEL);
> +	if (!wmi_priv.str_data)
> +		ret = -ENOMEM;
> +	return ret;
> +}
> +
> +/**
> + * populate_str_data() - Populate all properties of an instance under string attribute
> + * @str_obj: ACPI object with integer data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + **/
> +int populate_str_data(union acpi_object *str_obj, int instance_id, struct kobject *attr_name_kobj)
> +{
> +	wmi_priv.str_data[instance_id].attr_name_kobj = attr_name_kobj;
> +	strlcpy_attr(wmi_priv.str_data[instance_id].attribute_name,
> +		     str_obj[ATTR_NAME].string.pointer);
> +	strlcpy_attr(wmi_priv.str_data[instance_id].display_name_language_code,
> +		     str_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	strlcpy_attr(wmi_priv.str_data[instance_id].display_name,
> +		     str_obj[DISPLAY_NAME].string.pointer);
> +	strlcpy_attr(wmi_priv.str_data[instance_id].default_value,
> +		     str_obj[DEFAULT_VAL].string.pointer);
> +	strlcpy_attr(wmi_priv.str_data[instance_id].current_value,
> +		     str_obj[CURRENT_VAL].string.pointer);
> +	strlcpy_attr(wmi_priv.str_data[instance_id].dell_modifier,
> +		     str_obj[MODIFIER].string.pointer);
> +	wmi_priv.str_data[instance_id].min_length = (uintptr_t)str_obj[MIN_LEN].string.pointer;
> +	wmi_priv.str_data[instance_id].max_length = (uintptr_t) str_obj[MAX_LEN].string.pointer;
> +	strlcpy_attr(wmi_priv.str_data[instance_id].type, "string");
> +
> +	return sysfs_create_group(attr_name_kobj, &str_attr_group);
> +}
> +
> +/**
> + * exit_str_attributes() - Clear all attribute data
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_str_attributes(void)
> +{
> +	int instance_id;
> +
> +	for (instance_id = 0; instance_id < wmi_priv.str_instances_count; instance_id++) {
> +		if (wmi_priv.str_data[instance_id].attr_name_kobj)
> +			sysfs_remove_group(wmi_priv.str_data[instance_id].attr_name_kobj,
> +								&str_attr_group);
> +	}
> +	kfree(wmi_priv.str_data);
> +}
> diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell-wmi-sysman/sysman.c
> new file mode 100644
> index 000000000000..df32abe5261e
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
> @@ -0,0 +1,589 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common methods for use with dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/fs.h>
> +#include <linux/dmi.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/wmi.h>
> +#include "dell-wmi-sysman.h"
> +
> +#define MAX_TYPES  4
> +
> +static struct class firmware_attributes_class = {
> +	.name = "firmware-attributes",
> +};
> +
> +struct wmi_sysman_priv wmi_priv = {
> +	.mutex = __MUTEX_INITIALIZER(wmi_priv.mutex),
> +};
> +
> +/* reset bios to defaults */
> +static const char * const reset_types[] = {"builtinsafe", "lastknowngood", "factory", "custom"};
> +static int reset_option = -1;
> +
> +/**
> + * calculate_security_buffer() - determines size of security buffer for authentication scheme
> + *
> + * Currently only supported type is Admin password
> + **/
> +size_t calculate_security_buffer(void)
> +{
> +	if (strlen(wmi_priv.current_admin_password) > 0) {
> +		return (sizeof(u32) * 2) +
> +			strlen(wmi_priv.current_admin_password) +
> +			strlen(wmi_priv.current_admin_password) % 2;
> +	}
> +	return sizeof(u32) * 2;
> +}
> +
> +/**
> + * populate_security_buffer() - builds a security buffer for authentication scheme
> + * @buffer: the buffer to populate
> + * @authentication: the authentication content
> + *
> + * Currently only supported type is PLAIN TEXT
> + **/
> +void populate_security_buffer(char *buffer, char *authentication)
> +{
> +	char *auth = buffer + sizeof(u32)*2;
> +	u32 *sectype = (u32 *) buffer;
> +	u32 *seclen = sectype + 1;
> +	/* plain text */
> +	*sectype = 1;
> +	*seclen = strlen(authentication);
> +	memcpy(auth, authentication, *seclen);
> +}
> +
> +/**
> + * map_wmi_error() - map errors from WMI methods to kernel error codes
> + * @error_code: integer error code returned from Dell's firmware
> + **/
> +int map_wmi_error(int error_code)
> +{
> +	switch (error_code) {
> +	case 0:
> +		/* success */
> +		return 0;
> +	case 1:
> +		/* failed */
> +		return -EIO;
> +	case 2:
> +		/* invalid parameter */
> +		return -EINVAL;
> +	case 3:
> +		/* access denied */
> +		return -EACCES;
> +	case 4:
> +		/* not supported */
> +		return -EOPNOTSUPP;
> +	case 5:
> +		/* memory error */
> +		return -ENOMEM;
> +	case 6:
> +		/* protocol error */
> +		return -EPROTO;
> +	}
> +	/* unspecified error */
> +	return -EIO;
> +}
> +
> +/**
> + * reset_bios_show() - sysfs implementaton for read reset_bios
> + * @kobj: Kernel object for this attribute
> + * @attr: Kernel object attribute
> + * @buf: The buffer to display to userspace
> + **/
> +static ssize_t reset_bios_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	char *start = buf;
> +	int i;
> +
> +	for (i = 0; i < MAX_TYPES; i++) {
> +		if (i == reset_option)
> +			buf += sprintf(buf, "[%s] ", reset_types[i]);
> +		else
> +			buf += sprintf(buf, "%s ", reset_types[i]);
> +	}
> +	buf += sprintf(buf, "\n");
> +	return buf-start;
> +}
> +
> +/**
> + * reset_bios_store() - sysfs implementaton for write reset_bios
> + * @kobj: Kernel object for this attribute
> + * @attr: Kernel object attribute
> + * @buf: The buffer from userspace
> + * @count: the size of the buffer from userspace
> + **/
> +static ssize_t reset_bios_store(struct kobject *kobj,
> +				struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	int len, ret, i;
> +	int type = -1;
> +	char *p;
> +
> +	p = memchr(buf, '\n', count);
> +	if (p != NULL)
> +		*p = '\0';
> +	len = p ? p - buf : count;
> +
> +	for (i = 0; i < MAX_TYPES; i++) {
> +		if (len == strlen(reset_types[i])
> +		    && !strncmp(buf, reset_types[i], len)) {
> +			type = i;
> +			break;
> +		}
> +	}
> +
> +	if (type < 0 || type >= MAX_TYPES) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = set_bios_defaults(type);
> +	pr_debug("reset all attributes request type %d: %d\n", type, ret);
> +	if (ret) {
> +		ret = -EINVAL;
> +	} else {
> +		reset_option = type;
> +		ret = count;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +/**
> + * pending_reboot_show() - sysfs implementaton for read pending_reboot
> + * @kobj: Kernel object for this attribute
> + * @attr: Kernel object attribute
> + * @buf: The buffer to display to userspace
> + *
> + * Stores default value as 0
> + * When current_value is changed this attribute is set to 1 to notify reboot may be required
> + **/
> +static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *attr,
> +				   char *buf)
> +{
> +	return sprintf(buf, "%d\n", wmi_priv.pending_changes);
> +}
> +
> +static struct kobj_attribute reset_bios = __ATTR_RW(reset_bios);
> +static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
> +
> +
> +/**
> + * create_reset_bios() - Creates reset_bios and pending_reboot attributes
> + **/
> +static int create_reset_bios(void)
> +{
> +	int ret = sysfs_create_file(&wmi_priv.main_dir_kset->kobj, &reset_bios.attr);
> +
> +	if (ret) {
> +		pr_debug("could not create reset_bios file\n");
> +		return ret;
> +	}
> +
> +	ret = sysfs_create_file(&wmi_priv.main_dir_kset->kobj, &pending_reboot.attr);
> +	if (ret) {
> +		pr_debug("could not create changing_pending_reboot file\n");
> +		sysfs_remove_file(&wmi_priv.main_dir_kset->kobj, &reset_bios.attr);
> +	}
> +	return ret;
> +}
> +
> +static void release_reset_bios_data(void)
> +{
> +	sysfs_remove_file(&wmi_priv.main_dir_kset->kobj, &reset_bios.attr);
> +	sysfs_remove_file(&wmi_priv.main_dir_kset->kobj, &pending_reboot.attr);
> +}
> +
> +static ssize_t wmi_sysman_attr_show(struct kobject *kobj, struct attribute *attr,
> +				    char *buf)
> +{
> +	struct kobj_attribute *kattr;
> +	ssize_t ret = -EIO;
> +
> +	kattr = container_of(attr, struct kobj_attribute, attr);
> +	if (kattr->show)
> +		ret = kattr->show(kobj, kattr, buf);
> +	return ret;
> +}
> +
> +static ssize_t wmi_sysman_attr_store(struct kobject *kobj, struct attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct kobj_attribute *kattr;
> +	ssize_t ret = -EIO;
> +
> +	kattr = container_of(attr, struct kobj_attribute, attr);
> +	if (kattr->store)
> +		ret = kattr->store(kobj, kattr, buf, count);
> +	return ret;
> +}
> +
> +const struct sysfs_ops wmi_sysman_kobj_sysfs_ops = {
> +	.show	= wmi_sysman_attr_show,
> +	.store	= wmi_sysman_attr_store,
> +};
> +
> +static void attr_name_release(struct kobject *kobj)
> +{
> +	kfree(kobj);
> +}
> +
> +static struct kobj_type attr_name_ktype = {
> +	.release	= attr_name_release,
> +	.sysfs_ops	= &wmi_sysman_kobj_sysfs_ops,
> +};
> +
> +/**
> + * strlcpy_attr - Copy a length-limited, NULL-terminated string with bound checks
> + * @dest: Where to copy the string to
> + * @src: Where to copy the string from
> + **/
> +void strlcpy_attr(char *dest, char *src)
> +{
> +	size_t len = strlen(src) + 1;
> +
> +	if (len > 1 && len < MAX_BUFF)
> +		strlcpy(dest, src, len);
> +
> +	/*len can be zero because any property not-applicable to attribute can
> +	 * be empty so check only for too long buffers and log error
> +	 */
> +	if (len > MAX_BUFF)
> +		pr_err("Source string returned from BIOS is out of bound!\n");
> +}
> +
> +/**
> + * get_wmiobj_pointer() - Get Content of WMI block for particular instance
> + * @instance_id: WMI instance ID
> + * @guid_string: WMI GUID (in str form)
> + *
> + * Fetches the content for WMI block (instance_id) under GUID (guid_string)
> + * Caller must kfree the return
> + **/
> +union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid_string)
> +{
> +	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status;
> +
> +	status = wmi_query_block(guid_string, instance_id, &out);
> +
> +	return ACPI_SUCCESS(status) ? (union acpi_object *)out.pointer : NULL;
> +}
> +
> +/**
> + * get_instance_count() - Compute total number of instances under guid_string
> + * @guid_string: WMI GUID (in string form)
> + **/
> +int get_instance_count(const char *guid_string)
> +{
> +	union acpi_object *wmi_obj = NULL;
> +	int i = 0;
> +
> +	do {
> +		kfree(wmi_obj);
> +		wmi_obj = get_wmiobj_pointer(i, guid_string);
> +		i++;
> +	} while (wmi_obj);
> +
> +	return (i-1);
> +}
> +
> +/**
> + * alloc_attributes_data() - Allocate attributes data for a particular type
> + * @attr_type: Attribute type to allocate
> + **/
> +static int alloc_attributes_data(int attr_type)
> +{
> +	int retval = 0;
> +
> +	switch (attr_type) {
> +	case ENUM:
> +		retval = alloc_enum_data();
> +		break;
> +	case INT:
> +		retval = alloc_int_data();
> +		break;
> +	case STR:
> +		retval = alloc_str_data();
> +		break;
> +	case PO:
> +		retval = alloc_po_data();
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return retval;
> +}
> +
> +/**
> + * destroy_attribute_objs() - Free a kset of kobjects
> + * @kset: The kset to destroy
> + *
> + * Fress kobjects created for each attribute_name under attribute type kset
> + **/
> +static void destroy_attribute_objs(struct kset *kset)
> +{
> +	struct kobject *pos, *next;
> +
> +	list_for_each_entry_safe(pos, next, &kset->list, entry) {
> +		kobject_put(pos);
> +	}
> +}
> +
> +/**
> + * release_attributes_data() - Clean-up all sysfs directories and files created
> + **/
> +static void release_attributes_data(void)
> +{
> +	release_reset_bios_data();
> +
> +	mutex_lock(&wmi_priv.mutex);
> +	exit_enum_attributes();
> +	exit_int_attributes();
> +	exit_str_attributes();
> +	exit_po_attributes();
> +	destroy_attribute_objs(wmi_priv.main_dir_kset);
> +	destroy_attribute_objs(wmi_priv.authentication_dir_kset);
> +	kset_unregister(wmi_priv.main_dir_kset);
> +	kset_unregister(wmi_priv.authentication_dir_kset);
> +	mutex_unlock(&wmi_priv.mutex);
> +
> +}
> +
> +/**
> + * init_bios_attributes() - Initialize all attributes for a type
> + * @attr_type: The attribute type to initialize
> + * @guid: The WMI GUID associated with this type to initialize
> + *
> + * Initialiaze all 4 types of attributes enumeration, integer, string and password object.
> + * Populates each attrbute typ's respective properties under sysfs files
> + **/
> +static int init_bios_attributes(int attr_type, const char *guid)
> +{
> +	struct kobject *attr_name_kobj; //individual attribute names
> +	union acpi_object *obj = NULL;
> +	union acpi_object *elements;
> +	struct kset *tmp_set;
> +
> +	/* instance_id needs to be reset for each type GUID
> +	 * also, instance IDs are unique within GUID but not across
> +	 */
> +	int instance_id = 0;
> +	int retval = 0;
> +
> +	retval = alloc_attributes_data(attr_type);
> +	if (retval)
> +		return retval;
> +	/* need to use specific instance_id and guid combination to get right data */
> +	obj = get_wmiobj_pointer(instance_id, guid);
> +	if (!obj)
> +		return -ENODEV;
> +	elements = obj->package.elements;
> +
> +	mutex_lock(&wmi_priv.mutex);
> +	while (elements) {
> +		/* sanity checking */
> +		if (strlen(elements[ATTR_NAME].string.pointer) == 0) {
> +			pr_debug("empty attribute found\n");
> +			goto nextobj;
> +		}
> +		if (attr_type == PO)
> +			tmp_set = wmi_priv.authentication_dir_kset;
> +		else
> +			tmp_set = wmi_priv.main_dir_kset;
> +
> +		if (kset_find_obj(tmp_set, elements[ATTR_NAME].string.pointer)) {
> +			pr_debug("duplicate attribute name found - %s\n",
> +				elements[ATTR_NAME].string.pointer);
> +			goto nextobj;
> +		}
> +
> +		/* build attribute */
> +		attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
> +		if (!attr_name_kobj)
> +			goto err_attr_init;
> +
> +		attr_name_kobj->kset = tmp_set;
> +
> +		retval = kobject_init_and_add(attr_name_kobj, &attr_name_ktype, NULL, "%s",
> +						elements[ATTR_NAME].string.pointer);
> +		if (retval) {
> +			kobject_put(attr_name_kobj);
> +			goto err_attr_init;
> +		}
> +
> +		/* enumerate all of this attribute */
> +		switch (attr_type) {
> +		case ENUM:
> +			retval = populate_enum_data(elements, instance_id, attr_name_kobj);
> +			break;
> +		case INT:
> +			retval = populate_int_data(elements, instance_id, attr_name_kobj);
> +			break;
> +		case STR:
> +			retval = populate_str_data(elements, instance_id, attr_name_kobj);
> +			break;
> +		case PO:
> +			retval = populate_po_data(elements, instance_id, attr_name_kobj);
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (retval) {
> +			pr_debug("failed to populate %s\n",
> +				elements[ATTR_NAME].string.pointer);
> +			goto err_attr_init;
> +		}
> +
> +nextobj:
> +		kfree(obj);
> +		instance_id++;
> +		obj = get_wmiobj_pointer(instance_id, guid);
> +		elements = obj ? obj->package.elements : NULL;
> +	}
> +
> +	goto out;
> +
> +err_attr_init:
> +	release_attributes_data();
> +	kfree(obj);
> +out:
> +	mutex_unlock(&wmi_priv.mutex);
> +	return retval;
> +}
> +
> +static int __init sysman_init(void)
> +{
> +	int ret = 0;
> +	struct device *class_dev;
> +
> +	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> +	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
> +		pr_err("Unable to run on non-Dell system\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = init_bios_attr_set_interface();
> +	if (ret || !wmi_priv.bios_attr_wdev) {
> +		pr_debug("failed to initialize set interface\n");
> +		goto fail_set_interface;
> +	}
> +
> +	ret = init_bios_attr_pass_interface();
> +	if (ret || !wmi_priv.password_attr_wdev) {
> +		pr_debug("failed to initialize pass interface\n");
> +		goto fail_pass_interface;
> +	}
> +
> +	ret = class_register(&firmware_attributes_class);
> +	if (ret)
> +		goto fail_class;
> +
> +	class_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
> +				  NULL, "%s", DRIVER_NAME);
> +	if (IS_ERR(class_dev)) {
> +		ret = PTR_ERR(class_dev);
> +		goto fail_classdev;
> +	}
> +
> +	wmi_priv.main_dir_kset = kset_create_and_add("attributes", NULL,
> +						     &class_dev->kobj);
> +	if (!wmi_priv.main_dir_kset) {
> +		ret = -ENOMEM;
> +		goto fail_main_kset;
> +	}
> +
> +	wmi_priv.authentication_dir_kset = kset_create_and_add("authentication", NULL,
> +								&class_dev->kobj);
> +	if (!wmi_priv.authentication_dir_kset) {
> +		ret = -ENOMEM;
> +		goto fail_authentication_kset;
> +	}
> +
> +	ret = create_reset_bios();
> +	if (ret) {
> +		pr_debug("could not create reset BIOS attribute\n");
> +		goto fail_reset_bios;
> +	}
> +
> +	ret = init_bios_attributes(ENUM, DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
> +	if (ret) {
> +		pr_debug("failed to populate enumeration type attributes\n");
> +		goto fail_create_group;
> +	}
> +
> +	ret = init_bios_attributes(INT, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
> +	if (ret) {
> +		pr_debug("failed to populate integer type attributes\n");
> +		goto fail_create_group;
> +	}
> +
> +	ret = init_bios_attributes(STR, DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
> +	if (ret) {
> +		pr_debug("failed to populate string type attributes\n");
> +		goto fail_create_group;
> +	}
> +
> +	ret = init_bios_attributes(PO, DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID);
> +	if (ret) {
> +		pr_debug("failed to populate pass object type attributes\n");
> +		goto fail_create_group;
> +	}
> +
> +	return 0;
> +
> +fail_create_group:
> +	release_attributes_data();
> +
> +fail_reset_bios:
> +	kset_unregister(wmi_priv.authentication_dir_kset);
> +
> +fail_authentication_kset:
> +	kset_unregister(wmi_priv.main_dir_kset);
> +
> +fail_main_kset:
> +	device_destroy(&firmware_attributes_class, MKDEV(0, 0));
> +
> +fail_classdev:
> +	class_unregister(&firmware_attributes_class);
> +
> +fail_class:
> +	exit_bios_attr_pass_interface();
> +
> +fail_pass_interface:
> +	exit_bios_attr_set_interface();
> +
> +fail_set_interface:
> +	return ret;
> +}
> +
> +static void __exit sysman_exit(void)
> +{
> +	release_attributes_data();
> +	exit_bios_attr_set_interface();
> +	exit_bios_attr_pass_interface();
> +	device_destroy(&firmware_attributes_class, MKDEV(0, 0));
> +	class_unregister(&firmware_attributes_class);
> +}
> +
> +module_init(sysman_init);
> +module_exit(sysman_exit);
> +
> +MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
> +MODULE_AUTHOR("Prasanth Ksr <prasanth.ksr@dell.com>");
> +MODULE_AUTHOR("Divya Bharathi <divya.bharathi@dell.com>");
> +MODULE_DESCRIPTION("Dell platform setting control interface");
> +MODULE_LICENSE("GPL");
> 

