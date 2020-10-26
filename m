Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE6298F82
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781683AbgJZOiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1781652AbgJZOhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603723028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Ad72T/EfKVcStyefpPIp/gifN6+TWG5IeC2d/t+1tU=;
        b=d/B1AVWJz2ixLcjlCW0TE6hNrN40Cn3QB10bP+swzcKjmX/HlVsw320edvJ6GabixlLAty
        tPQyV+2rrDKxiMkpNE+lzR5e7U8VXtdShJw7aacitqsSQ6Zd6MbNgy646MuO+/8grIuu0C
        c2c3lIGN27o7ki56bSuQ6UzVfKm+EMs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-DgN6ts_7NOmS614CuX8q5A-1; Mon, 26 Oct 2020 10:37:06 -0400
X-MC-Unique: DgN6ts_7NOmS614CuX8q5A-1
Received: by mail-ed1-f70.google.com with SMTP id cb27so4397164edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Ad72T/EfKVcStyefpPIp/gifN6+TWG5IeC2d/t+1tU=;
        b=op416gZfDvcS+rnmwe4PtntjGqNZAo+/TaLgNsPMjQ1G95EvuiKWd0ZX/hpLg4JmAd
         /MJiv0SILtjvuQ9QMnHuT895146zOA+kIrbERE9ZQ3yZTDgscrvomWrM+8bgyXQx1brW
         9vyPuOpUzvsru3R/G2DFI0n8br7YPZoWCq2Rc/H9wTyPUAto3OIAamcWuWelLtJxPRZL
         RP5xjZirbOB1Qq0lpfxqzsAG0oREyJWOj5dFt92KM7gRKnwoeXuO+zYc9ubvzDKpOmZT
         nx7qTlCa7iwgYK6l8nu8cvd8LUe/c1jsYkpXq2lWF8h+sPyCHkEzaQbcuIvpxDmgq8Iv
         XTJw==
X-Gm-Message-State: AOAM532jpJrPgzs6YG28KKsRjQoZyNHwFGo+TT2NgieL6aC0mc+VT2Lf
        Avm20bZ0GQ7aX+IbwF9iOAjJ3Wh6CyTIjL+8meJsOD7UHk60Vk21inTGXAjnsYqlqeVxnq+7Io1
        nnJgC6p83f861Pb1PUq+WgLkQ
X-Received: by 2002:a17:906:bb14:: with SMTP id jz20mr16403830ejb.424.1603723024449;
        Mon, 26 Oct 2020 07:37:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfNW6w2zHWucjQOOZvfef728f/l0lSsiDtsrvvBkW13yQOzD9GrDbF1ZKMie0QO/KsLu1esQ==
X-Received: by 2002:a17:906:bb14:: with SMTP id jz20mr16403796ejb.424.1603723024001;
        Mon, 26 Oct 2020 07:37:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id a19sm5292705edb.84.2020.10.26.07.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:37:03 -0700 (PDT)
Subject: Re: [PATCH v6] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     Divya Bharathi <divya27392@gmail.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Divya Bharathi <divya.bharathi@dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>
References: <20201006082618.209287-1-divya.bharathi@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <101db8e3-70f0-4e85-b4b9-008995939b1a@redhat.com>
Date:   Mon, 26 Oct 2020 15:37:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201006082618.209287-1-divya.bharathi@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Full review below. Almost there, just a few small items remaining,
see remarks inline.

The most important 2 issues to fix are:

1. Rework the new populate_string_buffer function a bitl and add
   a new calculate_string_buffer helper.

2. Drop the !capable(CAP_SYS_ADMIN) checks, instead make the
   current_value attribute mode 0600.

If you can fix the remaining issues for v7, then I'll queue up v7
for merging into 5.11.

On 10/6/20 10:26 AM, Divya Bharathi wrote:
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

<snip>

> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> new file mode 100644
> index 000000000000..045daa797b4e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -0,0 +1,221 @@
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

This is missing a space between the a and 0/1. Also maybe align/indent all the descriptions
here to the same indentation depth as max_password_length that makes things a bit easier to
read.

> +
> +		role:	The type of authentication used.
> +			Known types:
> +				bios-admin: Representing a BIOS administrator password
> +				power-on: Representing a password required to use the system

Can you please add "This attribute is mandatory". here ?
> +
> +		mechanism:	The means of authentication.
> +				Only supported type currently is "password".

And also please add another "This attribute is mandatory". here ?

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
> +					This attribute is mandatory when mechanism == "password".
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

<snip>

> diff --git a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
> new file mode 100644
> index 000000000000..61e77b581d71
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to SET methods under BIOS attributes interface GUID for use
> + * with dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
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
> +		kobject_uevent(&wmi_priv.class_dev->kobj, KOBJ_CHANGE);
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
> + */
> +int set_attribute(const char *a_name, const char *a_value)
> +{
> +	size_t security_area_size, string_area_size, buffer_size;
> +	char *buffer = NULL, *start;
> +	int ret;
> +
> +	mutex_lock(&wmi_priv.mutex);
> +	if (!wmi_priv.bios_attr_wdev) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	/* build/calculate buffer */
> +	security_area_size = calculate_security_buffer(wmi_priv.current_admin_password);
> +	string_area_size = (strlen(a_name) + strlen(a_value)) * sizeof(u16);
> +	buffer_size = security_area_size + string_area_size + sizeof(u16) * 2;
> +	buffer = kzalloc(buffer_size, GFP_KERNEL);
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* build security area */
> +	populate_security_buffer(buffer, wmi_priv.current_admin_password);
> +
> +	/* build variables to set */
> +	start = buffer + security_area_size;
> +	ret = populate_string_buffer(start, a_name);
> +	if (ret < 0)
> +		goto out;
> +	start += sizeof(u16) + ret;
> +	ret = populate_string_buffer(start, a_value);
> +	if (ret < 0)
> +		goto out;

See my remarks about populate_string_buffer() below.

> +
> +	print_hex_dump_bytes("set attribute data: ", DUMP_PREFIX_NONE, buffer, buffer_size);

This seems to be a debugging left-over?

> +	ret = call_biosattributes_interface(wmi_priv.bios_attr_wdev,
> +					    buffer, buffer_size,
> +					    SETATTRIBUTE_METHOD_ID);
> +	if (ret == -EOPNOTSUPP)
> +		dev_err(&wmi_priv.bios_attr_wdev->dev, "admin password must be configured\n");
> +	else if (ret == -EACCES)
> +		dev_err(&wmi_priv.bios_attr_wdev->dev, "invalid password\n");
> +
> +out:
> +	kfree(buffer);
> +	mutex_unlock(&wmi_priv.mutex);
> +	return ret;
> +}

<snip>

> diff --git a/drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h b/drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h
> new file mode 100644
> index 000000000000..21ee63e37e83
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h

<snip>

> +#define attribute_property_store(curr_val, type)				\
> +static ssize_t curr_val##_store(struct kobject *kobj,				\
> +				struct kobj_attribute *attr,			\
> +				const char *buf, size_t count)			\
> +{										\
> +	char *p, *buf_cp;							\
> +	int i, ret = -EIO;							\
> +	buf_cp = kstrdup(buf, GFP_KERNEL);					\

You are missing a:
	if (!buf_cp)
		return -ENOMEM;

check here!

> +	p = memchr(buf_cp, '\n', count);					\
> +										\
> +	if (p != NULL)								\
> +		*p = '\0';							\
> +	i = get_##type##_instance_id(kobj);					\
> +	if (i >= 0)								\
> +		ret = validate_##type##_input(i, buf_cp);			\
> +	if (!ret)								\
> +		ret = set_attribute(kobj->name, buf_cp);			\
> +	kfree(buf_cp);								\
> +	return ret ? ret : count;						\
> +}

<snip>

> diff --git a/drivers/platform/x86/dell-wmi-sysman/enum-attributes.c b/drivers/platform/x86/dell-wmi-sysman/enum-attributes.c
> new file mode 100644
> index 000000000000..00e2e5138be2
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/enum-attributes.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to enumeration type attributes under
> + * BIOS Enumeration GUID for use with dell-wmi-sysman
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
> +	union acpi_object *obj;
> +	int instance_id;
> +	ssize_t ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;

So as mentioned in the discussion around v5 of the patch, please drop this check
and instead make this attribute only readable by root by changing the atrribute
declaration from:

attribute_property_store(current_value, enumeration);
static struct kobj_attribute current_val =
                __ATTR_RW(current_value);

To:

attribute_property_store(current_value, enumeration);
static struct kobj_attribute current_val = __ATTR_RW_MODE(current_value, 0600);


> +	instance_id = get_enumeration_instance_id(kobj);
> +	if (instance_id < 0)
> +		return instance_id;
> +
> +	/* need to use specific instance_id and guid combination to get right data */
> +	obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
> +	if (!obj)
> +		return -EIO;

Maybe insert a type-check here before dereferencing the pointer ?  :

	if (obj->package.elements[CURRENT_VAL].type != ACPI_TYPE_STRING) {
		ret = -EINVAL;
		goto out;
	}

> +	ret = snprintf(buf, PAGE_SIZE, "%s\n", obj->package.elements[CURRENT_VAL].string.pointer);
out:
> +	kfree(obj);
> +	return ret;
> +}

<snip>

> diff --git a/drivers/platform/x86/dell-wmi-sysman/int-attributes.c b/drivers/platform/x86/dell-wmi-sysman/int-attributes.c
> new file mode 100644
> index 000000000000..666232b3a4cb
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/int-attributes.c
> @@ -0,0 +1,173 @@
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
> +	union acpi_object *obj;
> +	int instance_id;
> +	ssize_t ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;

Same remark as for this check in enum-attributes.c.

> +	instance_id = get_integer_instance_id(kobj);
> +	if (instance_id < 0)
> +		return instance_id;
> +
> +	/* need to use specific instance_id and guid combination to get right data */
> +	obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
> +	if (!obj)
> +		return -EIO;
> +	ret = snprintf(buf, PAGE_SIZE, "%ld\n",
> +			(uintptr_t)obj->package.elements[CURRENT_VAL].string.pointer);

This was present in previous versions too, but I just noticed this are you sure that using
.string.pointer is correct here? That seems wrong since the pointer gets allocated by
the Linux ACPI core, so it is not under influence of the AML code?

I think you want / need to use ".integer.value" here ?

And maybe first do a type check, e.g.:

	if (obj->package.elements[CURRENT_VAL].type != ACPI_TYPE_INTEGER) {
		ret = -EINVAL;
		goto out;
	}

Adding this type check will also show if I'm right that you should use
.integer.value ...

	ret = snprintf(buf, PAGE_SIZE, "%lld\n", obj->package.elements[CURRENT_VAL].integer.value);
out:
> +	kfree(obj);
> +	return ret;
> +}

<snip>

> diff --git a/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
> new file mode 100644
> index 000000000000..af77470cef50
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
> @@ -0,0 +1,190 @@
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
> +	union acpi_object *obj;
> +	ssize_t ret;
> +	int instance_id = get_po_instance_id(kobj);
> +
> +	if (instance_id < 0)
> +		return instance_id;
> +
> +	/* need to use specific instance_id and guid combination to get right data */
> +	obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID);
> +	if (!obj)
> +		return -EIO;
> +
> +	ret = sprintf(buf, "%ld\n",
> +		(uintptr_t)obj->package.elements[IS_PASS_SET].string.pointer);

Again I think you want / need to use ".integer.value" here ? + add a type-check ?

> +	kfree(obj);
> +	return ret;
> +}
> +
> +struct kobj_attribute po_is_pass_set =
> +		__ATTR_RO(is_enabled);
> +
> +static ssize_t current_password_store(struct kobject *kobj,
> +				      struct kobj_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	char *target = NULL;
> +	int length;
> +
> +	length = strlen(buf);
> +	if (buf[length-1] == '\n')
> +		length--;
> +
> +	/* firmware does verifiation of min/max password length,
> +	 * hence only check for not exceeding MAX_BUFF here.
> +	 */
> +	if (length > MAX_BUFF)

You need to check for length >= MAX_BUFF here, otherwise
the 0 terminator may be written beyond the end of the buffer.

> +		return -EINVAL;
> +
> +	if (strcmp(kobj->name, "Admin") == 0)
> +		target = wmi_priv.current_admin_password;
> +	else if (strcmp(kobj->name, "System") == 0)
> +		target = wmi_priv.current_system_password;
> +	if (!target)
> +		return -EIO;
> +	memcpy(target, buf, length);
> +	target[length] = '\0';
> +
> +	return count;
> +}
> +
> +struct kobj_attribute po_current_password =
> +		__ATTR_WO(current_password);
> +
> +static ssize_t new_password_store(struct kobject *kobj,
> +				  struct kobj_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	char *p, *buf_cp;
> +	int ret;
> +
> +	buf_cp = kstrdup(buf, GFP_KERNEL);

You are missing a:

	if (!buf_cp)
		return -ENOMEM;

check here!

> +	p = memchr(buf_cp, '\n', count);
> +
> +	if (p != NULL)
> +		*p = '\0';
> +	if (strlen(buf_cp) > MAX_BUFF) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = set_new_password(kobj->name, buf_cp);
> +
> +out:
> +	kfree(buf_cp);
> +	return ret ? ret : count;
> +}

<snip>

> diff --git a/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c b/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
> new file mode 100644
> index 000000000000..7bcadc1a43b8
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to SET password methods under BIOS attributes interface GUID
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
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
> +	kobject_uevent(&wmi_priv.class_dev->kobj, KOBJ_CHANGE);
> +	return map_wmi_error(ret);
> +}
> +
> +/**
> + * set_new_password() - Sets a system admin password
> + * @password_type: The type of password to set
> + * @new: The new password
> + *
> + * Sets the password using plaintext interface
> + */
> +int set_new_password(const char *password_type, const char *new)
> +{
> +	size_t security_area_size, string_area_size, buffer_size;
> +	char *buffer = NULL, *start;
> +	char *current_password;
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
> +	security_area_size = calculate_security_buffer(wmi_priv.current_admin_password);
> +	string_area_size = (strlen(password_type) + strlen(current_password)
> +			+ strlen(new))*sizeof(u16);
> +	buffer_size = security_area_size + string_area_size + sizeof(u16)*3;
> +	buffer = kzalloc(buffer_size, GFP_KERNEL);
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* build security area */
> +	populate_security_buffer(buffer, wmi_priv.current_admin_password);
> +
> +	/* build variables to set */
> +	start = buffer + security_area_size;
> +	ret = populate_string_buffer(start, password_type);
> +	if (ret < 0)
> +		goto out;
> +
> +	start += sizeof(u16) + ret;
> +	ret = populate_string_buffer(start, current_password);
> +	if (ret < 0)
> +		goto out;
> +
> +	start += sizeof(u16) + ret;
> +	ret = populate_string_buffer(start, new);
> +	if (ret < 0)
> +		goto out;

See my remarks about populate_string_buffer() below.

> +	print_hex_dump_bytes("set new password data: ", DUMP_PREFIX_NONE, buffer, buffer_size);

This seems to be a debugging left-over?

> +	ret = call_password_interface(wmi_priv.password_attr_wdev, buffer, buffer_size);
> +	/* clear current_password here and use user input from wmi_priv.current_password */
> +	if (!ret)
> +		current_password = "";

This will not work you are now assigning the current_password pointer to point to
a new const empty string. IOW this does not change wmi_priv.current_admin_password /
wmi_priv.current_system_password which I believe is your intention here?

If I've understood your intention correct, then what you want is:

	if (!ret)
		current_password[0] = 0;

Or maybe even better as it completely clears the old password from memory:

	if (!ret)
		memset(current_password, 0, MAX_BUFF);

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

<snip>

> diff --git a/drivers/platform/x86/dell-wmi-sysman/string-attributes.c b/drivers/platform/x86/dell-wmi-sysman/string-attributes.c
> new file mode 100644
> index 000000000000..463b94f505ad
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/string-attributes.c
> @@ -0,0 +1,158 @@
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
> +	union acpi_object *obj;
> +	int instance_id;
> +	ssize_t ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;

Same remark as for this check in enum-attributes.c.

> +	instance_id = get_str_instance_id(kobj);
> +	if (instance_id < 0)
> +		return -EIO;
> +
> +	/* need to use specific instance_id and guid combination to get right data */
> +	obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
> +	if (!obj)
> +		return -EIO;
> +	ret = snprintf(buf, PAGE_SIZE, "%s\n", obj->package.elements[CURRENT_VAL].string.pointer);
> +	kfree(obj);
> +	return ret;
> +}

<snip>

> diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell-wmi-sysman/sysman.c
> new file mode 100644
> index 000000000000..b415021e7bd5
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
> @@ -0,0 +1,617 @@
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
> +#include <linux/nls.h>
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
> +
> +/**
> + * populate_string_buffer() - populates a string buffer
> + * @start: the start of the buffer
> + * @str: the string to insert into buffer
> + */
> +int populate_string_buffer(u8 *start, const char *str)
> +{
> +	u16 *target = (u16 *)start + 1;
> +	int ret;
> +
> +	ret = utf8s_to_utf16s(str, strlen(str), UTF16_HOST_ENDIAN,
> +			      target, MAX_BUFF);
> +	if (ret < 0) {
> +		dev_err(wmi_priv.class_dev, "UTF16 conversion failed\n");
> +		return ret;
> +	}
> +	*start = ret * 2;
> +	return *start;
> +}

Adding a helper for this is a good idea, thank you for doing that.

I do have some remarks though:

1. In most places you use size_t when passing around buffer sizes,
please do the same here (use ssize_t since the return can be negative).

2. All the callers are passing a char * as destination argument, please
make the first argument a char * as type, this avoids possible issues
reported by various static code analysis tools. This also makes the
arguments consistent with populate_security_buffer which takes a
"char *buffer" as first argument

3. You are still passing MAX_BUFF as destination size to utf8s_to_utf16s
while the caller is allocating strlen(str) * 2 bytes, so this can cause
a theoretical buffer overflow. Please add a destination length as extra
argument.

4. *start is an u8, what if the string takes 128 u16-s (or more) in
UTF16 format? then you store 2 * 128 = 256 in an u8, which will result
in storing 0 as length. Instead you should use an u16 * to store the length

5. You should also check that the length does not overflow an U16.

6. Instead of restoring only the space taken by the string, it would be
better to return the size of the string + the 2 bytes for storing the length,
this avoids the need to do " + sizeof(u16)" to the return in all the places
where you call this.

Taking all the remarks together a new improved version would look like this:

/**
 * populate_string_buffer() - populates a string buffer
 * @buffer: the start of the destination buffer
 * @buffer_len: length of the destination buffer
 * @str: the string to insert into buffer
 */
ssize_t populate_string_buffer(char *buffer, size_t buffer_len, const char *str)
{
	u16 *length = (u16 *)buffer;
	u16 *target = length + 1;
	int ret;

	ret = utf8s_to_utf16s(str, strlen(str), UTF16_HOST_ENDIAN,
			      target, buffer_len - sizeof(u16));
	if (ret < 0) {
		dev_err(wmi_priv.class_dev, "UTF16 conversion failed\n");
		return ret;
	}

	if ((ret * sizeof(u16)) > U16_MAX) {
		dev_err(wmi_priv.class_dev, "Error string too long\n");
		return -ERANGE;
	}

	*length = ret * sizeof(u16);
	return sizeof(u16) + *length;
}

And for consistency with how the security stuff is handled, I think
you should also add a calculate_string_buffer helper, this will
also lead to somewhat cleaner code in the callers of
populate_string_buffer:

size_t calculate_string_buffer(const char *str)
{
	/* u16 length field + one UTF16 char for each input char */
	return sizeof(u16) + strlen(str) * sizeof(u16);
}

And then in e.g. set_attribute() use the 2 functions like this:

	/* build/calculate buffer */
	security_area_size = calculate_security_buffer(wmi_priv.current_admin_password);
	a_name_size = calculate_string_buffer(a_name);
	a_value_size = calculate_string_buffer(a_value);
	buffer_size = security_area_size + a_name_size + a_value_size;
	buffer = kzalloc(buffer_size, GFP_KERNEL);
	if (!buffer) {
		ret = -ENOMEM;
		goto out;
	}

	/* build security area */
	populate_security_buffer(buffer, wmi_priv.current_admin_password);

	/* build variables to set */
	start = buffer + security_area_size;
	ret = populate_string_buffer(start, a_name_size, a_name);
	if (ret < 0)
		goto out;
	start += ret;
	ret = populate_string_buffer(start, a_value_size, a_value);
	if (ret < 0)
		goto out;


<snip>

> +/**
> + * reset_bios_store() - sysfs implementaton for write reset_bios
> + * @kobj: Kernel object for this attribute
> + * @attr: Kernel object attribute
> + * @buf: The buffer from userspace
> + * @count: the size of the buffer from userspace
> + */
> +static ssize_t reset_bios_store(struct kobject *kobj,
> +				struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	int ret;
> +	int type = -1;
> +	char *p, *buf_cp;
> +
> +	buf_cp = kstrdup(buf, GFP_KERNEL);

There is no need for a strdup here,
sysfs_match_string() takes care of the possible extra '\n'
itself, so you can simplify this entire function to:

static ssize_t reset_bios_store(struct kobject *kobj,
				struct kobj_attribute *attr, const char *buf, size_t count)
{
	int ret, type;

	type = sysfs_match_string(reset_types, buf_cp);
	if (type < 0)
		return type;

	ret = set_bios_defaults(type);
	pr_debug("reset all attributes request type %d: %d\n", type, ret);
	if (!ret) {
		reset_option = type;
		ret = count;
	}

	return ret;
}

> +	p = memchr(buf_cp, '\n', count);
> +	if (p != NULL)
> +		*p = '\0';
> +
> +	type = sysfs_match_string(reset_types, buf_cp);
> +	if (type < 0) {
> +		ret = type;
> +		goto out;
> +	}
> +
> +	ret = set_bios_defaults(type);
> +	pr_debug("reset all attributes request type %d: %d\n", type, ret);
> +	if (!ret) {
> +		reset_option = type;
> +		ret = count;
> +	}
> +
> +out:
> +	kfree(buf_cp);
> +	return ret;
> +}

<snip>

Regards,

Hans

