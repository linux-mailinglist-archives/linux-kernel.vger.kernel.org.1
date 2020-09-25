Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D706B278988
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgIYN05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728659AbgIYN05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:26:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601040413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XztNX/Wfcep2Dy4/cgczBa4y126efsuvA6aVI7u1qL8=;
        b=aOwEZ/nb/P836wd4ZgzHyL1LKHsgFdzbHx/BjifMBKsm3ZZQFHl85SHtqUs2gZW5MmtO+z
        arEhj+aLlxQC+uOZ7MKXuPRTJPcpMPWNjTV8VbFx/MiZbhbbG4TtxAQVnFP0Xb3iA56MhY
        X40gmxl8NYxjwGeQv46SNzf8eMQ8d9c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-FpfXYpwmNuSBRIdPzUFAGQ-1; Fri, 25 Sep 2020 09:26:49 -0400
X-MC-Unique: FpfXYpwmNuSBRIdPzUFAGQ-1
Received: by mail-ej1-f71.google.com with SMTP id v9so1027930ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 06:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XztNX/Wfcep2Dy4/cgczBa4y126efsuvA6aVI7u1qL8=;
        b=nFQHdVevwOpAicPN3VPGTpjMzBHMKSr6aV/OewQIS0Bq+/3at7Oj8ciVl9Ti5rvHNt
         LTXp37tHvm/GTWFtps8mm/RpEmUe+h4TkEdZPL1o5ifCr6CZJlTITICM/Kzeg3J4obKy
         8CrH7JJaMpGr/1mD4wYxkE9Qwm1SAz2+snTSj9dt4qT30fQ7qHqbmFWwhQAgnLZ21SbI
         fPujkVpmN3iWyhegACrP/nuEgHcrp76FCWBIpwECK5EJFCpmXSpEnhrS8wJYySTDFpfA
         kH+JlxKy52n05Y/ryte9uTkisl8TTz8FdqYeouN3EeXFsDgsbYMphR+dZD5LB2O8i2N2
         y6eQ==
X-Gm-Message-State: AOAM530iy8gDNOQltkrgvt6q/4Hg4RnhC2c8K/LiYD9I/f9tGD6e3n9M
        i6wYDqkjANBJuUHAKh7dcNNzcWil+3aXeuDRxb/9WeqyBcczBsBU3eAXFms2Cb7MquWY7LsF620
        rP5QLgXEeSga+nUIVDECXsCck
X-Received: by 2002:a17:906:3552:: with SMTP id s18mr2686689eja.23.1601040408167;
        Fri, 25 Sep 2020 06:26:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0F21eD1UAtpJ1glaLiU23a0yEqhzAVdSS3IzGa1mJNWRQawjnuJgU2DkSUxpWqVsLo0Xuew==
X-Received: by 2002:a17:906:3552:: with SMTP id s18mr2686663eja.23.1601040407834;
        Fri, 25 Sep 2020 06:26:47 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-50c0-0578-5c19-877a.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:50c0:578:5c19:877a])
        by smtp.gmail.com with ESMTPSA id d13sm1815641edu.54.2020.09.25.06.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 06:26:47 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     Divya Bharathi <divya27392@gmail.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Divya Bharathi <divya.bharathi@dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>
References: <20200923113015.110980-1-divya.bharathi@dell.com>
Message-ID: <fc8315b6-a726-5c43-3858-b3201c2b525f@redhat.com>
Date:   Fri, 25 Sep 2020 15:26:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923113015.110980-1-divya.bharathi@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

So as usual I will split my remarks in 2 parts,
this first email will focus on the sysfs bits.

I will do a detailed review of the code coming Monday.

On 9/23/20 1:30 PM, Divya Bharathi wrote:
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

Thank you for all these changes.

Things are starting to look pretty good now to me, good work.


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
>   .../testing/sysfs-class-firmware-attributes   | 199 ++++++
>   MAINTAINERS                                   |   8 +
>   drivers/platform/x86/Kconfig                  |  12 +
>   drivers/platform/x86/Makefile                 |   1 +
>   drivers/platform/x86/dell-wmi-sysman/Makefile |   8 +
>   .../x86/dell-wmi-sysman/biosattr-interface.c  | 199 ++++++
>   .../x86/dell-wmi-sysman/dell-wmi-sysman.h     | 196 ++++++
>   .../x86/dell-wmi-sysman/enum-attributes.c     | 188 ++++++
>   .../x86/dell-wmi-sysman/int-attributes.c      | 169 +++++
>   .../x86/dell-wmi-sysman/passobj-attributes.c  | 153 +++++
>   .../dell-wmi-sysman/passwordattr-interface.c  | 167 +++++
>   .../x86/dell-wmi-sysman/string-attributes.c   | 156 +++++
>   drivers/platform/x86/dell-wmi-sysman/sysman.c | 589 ++++++++++++++++++
>   13 files changed, 2045 insertions(+)
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
> index 000000000000..ad45d5717071
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -0,0 +1,199 @@
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
> +		Attributes can accept:
> +		- a set of pre-defined valid values (enumeration)
> +		- a range of numerical values (integer)
> +		- a string
> +
> +		All attribute types support the following values:

This list seems to miss a "type" sysfs attribute, which tells which type
the firmware-attribute in question is. Sorry for not noticing that sooner.

> +
> +		current_value:	A file that can be read to obtain the current
> +		value of the <attr>

Can you indent the continuation on the second line to align with the start
of the description on the first line please?, e.g.:

		current_value:	A file that can be read to obtain the current
				value of the <attr>

This goes for all the sysfs-attribute description texts.

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
> +		"enumeration"-type specific properties:
> +
> +		possible_values: A file that can be read to obtain the possible
> +		values of the <attr>. Values are separated using semi-colon.

As non-native English speaker I had to lookup semi-colon to make sure that
it indeed is ';' as I already sorta expected. So can we add "(';')" (without
the "") behind the semi-colon to make this easier to parse for non-native English
speakers?

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

Can we have an example here? I guess if for some reason only even/odd values
are allowed then this would contain "2" ?

> +
> +		"string"-type specific properties:
> +
> +		max_length:	A file that can be read to obtain the maximum
> +		length value of the <attr>
> +
> +		min_length:	A file that can be read to obtain the minimum
> +		length value of the <attr>

So I have been taking a look at a community written driven to allow changing
BIOS-settings / firmware-attributes on some Lenovo laptops:

https://github.com/iksaif/thinkpad-wmi

My main reason for doing so is to check if other vendors also support things
like "display_name", "default_value", etc.

So for the normal attributes, it seems that for the Thinkpad WMI interface they
are all enums and the do contain possible_values. So that is fine.

But they do not have a separate display_name only a name-name, nor do they
have a default_value.

So I think we should mark the display_name, display_name_language_code and
default_value sysfs-attributes optional, e.g. make the description look like this:

		default_value:	An optional file that can be read to obtain the
				default value of the <attr>



> +		Dell specific class extensions
> +		--------------------------
> +
> +		On Dell systems the following additional attributes are available:
> +
> +		dell_modifier: A file that can be read to obtain attribute-level
> +		dependency rule. It says an attribute X will become read-only or
> +		suppressed, if/if-not attribute Y is configured.
> +
> +		modifier rules can be in following format,
> +		[ReadOnlyIf:<attribute>=<value>]
> +		[ReadOnlyIfNot:<attribute>=<value>]
> +		[SuppressIf:<attribute>=<value>]
> +		[SuppressIfNot:<attribute>=<value>]
> +
> +		For example:
> +		AutoOnFri/dell_modifier has value,
> +			[SuppressIfNot:AutoOn=SelectDays]
> +		This means AutoOnFri will be suppressed in BIOS setup if AutoOn
> +		attribute is not "SelectDays" and its value will not be effective
> +		through sysfs until this rule is met.
> +
> +		Enumeration attributes also support the following:
> +
> +		dell_value_modifier:	A file that can be read to obtain value-level
> +		dependency. This file is similar to dell_modifier but here, an
> +		attribute's current value will be forcefully changed based dependent
> +		attributes value.
> +
> +		dell_value_modifier rules can be in following format,
> +		<value>[ForceIf:<attribute>=<value>]
> +		<value>[ForceIfNot:<attribute>=<value>]
> +
> +		For example,
> +		LegacyOrom/dell_value_modifier has value,
> +			Disabled[ForceIf:SecureBoot=Enabled]
> +		This means LegacyOrom's current value will be forced to "Disabled"
> +		in BIOS setup if SecureBoot is Enabled and its value will not be
> +		effective through sysfs until this rule is met.

Thank you for making these Dell specific.

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
> +		is_authentication_set:	A file that can be read
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

First of all some generic remarks:

Currently the "Admin" and "System" names come directly from the Dell WMI
interface. I have 2 concerns with this:

1) What if we do get multiple authentication mechanisms for a single user,
e.g. both a type == "pasword" and type == "hotp" authentication. The way I have
been thinking about that sofar, is that we then get 2 admin dirs under the
/sys/class/firmware-attributes/*/authentication dir, with a type attribute
per dir, following how we do the attributes. So we would get e.g. these 2 dirs:

/sys/class/firmware-attributes/dell/authentication/admin-password
/sys/class/firmware-attributes/dell/authentication/admin-hotp

For the admin user. If want to do it like this in the future we should
add some indirection between the WMI username and the dir which is created
now and create the Admin dir as admin-password starting now.

2) The "Admin" name is clear enough, but the "System" name is somewhat
ambiguous and other vendors may call this differently, I think I have
at least seen it called the "User" password in some cases and Lenovo
seems to call it a power-on-password. I think that just calling it the
"boot" password makes sense. My main concern is that "System" is a bit
too vague. So then for now we would get:

/sys/class/firmware-attributes/dell/authentication/admin-password
/sys/class/firmware-attributes/dell/authentication/boot-password

The spec. should also specify that the part before the first '-' is the
username, and the part after it is the authentication type. E.g. the
docs for this could look something like this:

	Directories under /sys/class/firmware-attributes/*/authentication/
	use the following directory-name pattern:
	<username>-<authentication_method>

	Where username must be one of: "admin" or "boot":

	admin	If any authentication_method is enabled for the admin user, then
		authentication as the admin user is required to modify BIOS settings.
	boot	If any authentication_method is enabled for the admin user, then
		authentication as the boot user is required to boot the machine.

	And where authentication_method must be "password". Note in the future
	both more usernames and more authentication_method-s may be added.

	All authentication_methods must have the following sysfs-attributes:

	is_enabled:  This reads "1" if the authentication_method is enabled,
		     and "0" if its disabled

	Any changes to authentication_methods will generate a change uevent,
	upon receiving this event applications should recheck the authentication
	settings such as the is_enabled flag.

	Password authentication_method specific sysfs-attributes:

	max_password_length: ... (continue with the old text)

Note:

1) This is a proposal to make the authentication bits a bit more generic /
    future proof. This is very much open for discussion.

2) The new generic is_enabled sysfs-attribute replaces the is_authentication_set flag

###

So as with the actual firmware-attributes I have also been comparing the authentication
bits for the Dell case with the community thinkpad_wmi code. And again things are a pretty
good match already, including being able to query a minimum and maximin password length.

The only thing which is different, which I think would be good to add now, is
a password_encoding sysfs-attribute. The Lenovo password interface supports
2 encodings, "ascii" and "scancodes". Although I wonder if scancodes still
works on modern UEFI based platforms.

Since the Dell password code uses UTF8 to UTF16 translation routines, I guess
the encoding for the Dell password is UTF8 (at the sysfs level). So I would like to propose
an extra password-authentication attribute like:

	password_encoding:  A file that can be read to obtain the encoding used by
			    the current_password and new_password attributes.
			    The value returned should be one of: "utf8", "ascii".
			    In some cases this may return a vendor-specific encoding
			    like, e.g. "lenovo-scancodes".

And for the Dell driver this would just be hardcoded to utf8.

> +
> +		On Dell systems, if Admin password is set, then all BIOS attributes
> +		require password validation.

I think that this bit can be dropped both the new authentication text which I suggest
above, but even the old text:

> +		- An "Admin" password is used for preventing modification to the BIOS
> +		  settings.

Already makes it clear that if an Admin password is set modification of (any)
BIOS settings is not allowed without the password. So this seems redundant.

If in the future some attributes can be changed without the Admin password,
then we can deal with that then by introducing a new authorization_required
attribute, which could contain, e.g. one of "none, "admin", "<new-to-be-defined
-power-user-level-user>".

And when we define that optional attribute then we add that the absence of
said attribute means that the consumer of the API should behave as if the
authorization_requires attribute contains "admin", which existing API consumers
will already do as that is the behavior we define currently.


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

Regards,

Hans

