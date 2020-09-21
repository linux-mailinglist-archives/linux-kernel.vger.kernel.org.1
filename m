Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DD92722BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIULim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbgIULil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600688318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zn1lPU7+pGxNSCHcaxBiQCWtBTFhFTfuMbRf8/5Fq90=;
        b=LL8Bx+g1Od5UbYRLsu+QIq6uGiiaQScn7iLKPYDhP8Oh5ORKRj91V4L+yTyu1wKKDdRd4N
        fD//Kc/by+3kyI791eDP0VSFjWuCD9JIItyoN2dSffvDkvMZH3MKCbYsZo5omwTudERHo9
        V6oXKyt2Ffo+sSRrj/TkCvUzKEVCE1c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-gnbB8SWoOGugfgLO1crnuA-1; Mon, 21 Sep 2020 07:38:36 -0400
X-MC-Unique: gnbB8SWoOGugfgLO1crnuA-1
Received: by mail-ej1-f71.google.com with SMTP id w10so4717778ejq.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 04:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zn1lPU7+pGxNSCHcaxBiQCWtBTFhFTfuMbRf8/5Fq90=;
        b=a1oMoU5AEre0fnJdB8e7SbrGDqrAmy70U7wlVe4SdIse8mwwixwt3qj7UKEtDbC0ov
         nEgTlg8HYWCBs6C3RltPW6JqY/u3JTG8CXk9KNOMFtMc2/xhdmqAo7Z9a0GKmK5x7YQO
         EdL0Wv3yNGUIwcSzG7nFgtv+voBamT7cPIDc4V9pMIQW7xbX72OWnYP+KEzHmPzn3XWA
         VKQZoQmUX9/ZvoiU6hGChncu+f6g1HfmwgO8cmrlCwicvzg5JRS+j0pyAgB9Kh9MasH7
         w5erY24zkPzL7LA3YqZ4D5de0LGg1QnHImBxnGo4/dAp3qfMtxvrBE4MWQkOr+Bs2fl3
         VDEA==
X-Gm-Message-State: AOAM533/3KVsrg/BDzBcQD6m1Gpn2RXFo24l6yOLH+7tNeh2UDDHLTjK
        jU6E37hK3rCGT9OjP2v7IhUrLMCYD5H1SKwsDf/UmGU5tzOe85UfjcUgPdvlkhO6KOSts1/xisR
        XDMbBEltsU9qSlSMsCUtoZcXx
X-Received: by 2002:a17:906:2985:: with SMTP id x5mr48524741eje.136.1600688314670;
        Mon, 21 Sep 2020 04:38:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR3SD95b/Yy6F+i0bcHiuJrrbA5WvLVYOzex1T6egBxTYxxrPUoq+G3islxaE/ozOQWjhdVA==
X-Received: by 2002:a17:906:2985:: with SMTP id x5mr48524709eje.136.1600688314315;
        Mon, 21 Sep 2020 04:38:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q1sm8643080ejy.37.2020.09.21.04.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 04:38:33 -0700 (PDT)
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
Message-ID: <001ba7fe-fb88-cbe3-c413-1c6973b9e786@redhat.com>
Date:   Mon, 21 Sep 2020 13:38:33 +0200
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

Ok code review this time. Still mainly focussing on the overal
structure and not so much individual functions.

Note the code is starting to look good to me.

One general remark, now that we are keeping the 1 file per
type (int/enum/string) layout, there are quite a few files
in this driver. I think it would be good to create a
drivers/platform/x86/dell-wmi-sysman dir and put all the
files there, so that it is easier to e.g. grep for something
in all the files belonging to this driver.

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

<snip>

> diff --git a/drivers/platform/x86/dell-wmi-enum-attributes.c b/drivers/platform/x86/dell-wmi-enum-attributes.c
> new file mode 100644
> index 000000000000..4598c4e27310
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-enum-attributes.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to enumeration type attributes under BIOS Enumeration GUID for use
> + * with dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include "dell-wmi-sysman-attributes.h"
> +
> +/* kept variable names same as in sysfs file name for sysfs_show macro definition */
> +struct enumeration_data {
> +	char display_name_language_code[MAX_BUFF];
> +	char attribute_name[MAX_BUFF];
> +	char display_name[MAX_BUFF];
> +	char default_value[MAX_BUFF];
> +	char current_value[MAX_BUFF];
> +	char modifier[MAX_BUFF];
> +	int value_modifier_count;
> +	char value_modifier[MAX_BUFF];
> +	int possible_values_count;
> +	char possible_values[MAX_BUFF];
> +	char type[MAX_BUFF];
> +};
> +
> +static struct enumeration_data *enumeration_data;
> +static int enumeration_instances_count;

Can we put these 2 static globals inside the wmi_priv
data structure?  It does not matter much but I find it a bit
cleaner to have all global state together in a single place.

> +get_instance_id(enumeration);

This macro will need to be adjusted a bit then, but I don't
see any problem there, just put wmi_priv. in front of the
type##_instances_count and type##_data[i].attribute_name.

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
> +		strncpy_attr(enumeration_data[instance_id].current_value,
> +		       obj->package.elements[CURRENT_VAL].string.pointer);
> +		kfree(obj);
> +		return sprintf(buf, "%s\n", enumeration_data[instance_id].current_value);
> +	}
> +	return -EIO;
> +}
> +
> +/**
> + * validate_enumeration_input() - Validate input of current_value against possible values
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + **/
> +int validate_enumeration_input(int instance_id, const char *buf)
> +{
> +	char *options, *tmp, *p;
> +	int ret = -EINVAL;
> +
> +	options = tmp = kstrdup((enumeration_data[instance_id].possible_values), GFP_KERNEL);
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
> +struct kobj_attribute displ_name =
> +		__ATTR_RO(display_name);
> +
> +attribute_s_property_show(default_value, enumeration);
> +struct kobj_attribute default_val =
> +		__ATTR_RO(default_value);
> +
> +attribute_property_store(current_value, enumeration);
> +struct kobj_attribute current_val =
> +		__ATTR_RW(current_value);
> +
> +attribute_s_property_show(modifier, enumeration);
> +struct kobj_attribute modifier =
> +		__ATTR_RO(modifier);
> +
> +attribute_s_property_show(value_modifier, enumeration);
> +struct kobj_attribute value_modfr =
> +		__ATTR_RO(value_modifier);
> +
> +attribute_s_property_show(possible_values, enumeration);
> +struct kobj_attribute poss_val =
> +		__ATTR_RO(possible_values);
> +
> +attribute_s_property_show(type, enumeration);
> +struct kobj_attribute type =
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
> +	enumeration_instances_count = get_instance_count(DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
> +	enumeration_data = kzalloc((sizeof(struct enumeration_data) * enumeration_instances_count),
> +					GFP_KERNEL);

Please use kcalloc here, that will check that the
(sizeof(struct enumeration_data) * enumeration_instances_count multiplication does not
overflow. The same for all the other alloc_foo_data functions.

> +	if (!enumeration_data)
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
> +	int retval = sysfs_create_group(attr_name_kobj, &enumeration_attr_group);

This needs to be moved to the end of this function, as soon as you
call this, e.g. current_value_show() could be called, before the
enumeration_data[instance_id].current_value buffer has been filled.

The same goes for the other populate_foo() functions.

> +	int i, next_obj;
> +
> +	if (retval)
> +		goto out;
> +
> +	mutex_lock(&wmi_priv.mutex);

It would be better to push this lock (and the unlock) up into init_dell_bios_attrib_wmi()
this way we can ensure that none of the functions which take the lock can run
before we are completely done with initializing and registering all
the various sysfs attributes.

This lock/unlock can then also be removed from the other populate_foo()
functions.


> +	strncpy_attr(enumeration_data[instance_id].attribute_name,
> +		enumeration_obj[ATTR_NAME].string.pointer);
> +	strncpy_attr(enumeration_data[instance_id].display_name_language_code,
> +		enumeration_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	strncpy_attr(enumeration_data[instance_id].display_name,
> +		enumeration_obj[DISPLAY_NAME].string.pointer);
> +	strncpy_attr(enumeration_data[instance_id].default_value,
> +		enumeration_obj[DEFAULT_VAL].string.pointer);
> +	strncpy_attr(enumeration_data[instance_id].current_value,
> +		enumeration_obj[CURRENT_VAL].string.pointer);
> +	strncpy_attr(enumeration_data[instance_id].modifier,
> +		enumeration_obj[MODIFIER].string.pointer);
> +
> +	next_obj = MODIFIER + 1;
> +
> +	enumeration_data[instance_id].value_modifier_count =
> +		(uintptr_t)enumeration_obj[next_obj].string.pointer;
> +
> +	for (i = 0; i < enumeration_data[instance_id].value_modifier_count; i++) {
> +		strcat(enumeration_data[instance_id].value_modifier,
> +			enumeration_obj[++next_obj].string.pointer);
> +		strcat(enumeration_data[instance_id].value_modifier, ";");
> +	}
> +
> +	enumeration_data[instance_id].possible_values_count =
> +		(uintptr_t) enumeration_obj[++next_obj].string.pointer;
> +
> +	for (i = 0; i < enumeration_data[instance_id].possible_values_count; i++) {
> +		strcat(enumeration_data[instance_id].possible_values,
> +			enumeration_obj[++next_obj].string.pointer);
> +		strcat(enumeration_data[instance_id].possible_values, ";");
> +	}
> +	strncpy_attr(enumeration_data[instance_id].type, "enumeration");
> +	mutex_unlock(&wmi_priv.mutex);
> +
> +out:
> +	return retval;
> +}
> +
> +/**
> + * exit_enum_attributes() - Clear all attribute data
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_enum_attributes(void)
> +{
> +	struct kobject *pos, *next;
> +
> +	list_for_each_entry_safe(pos, next, &wmi_priv.main_dir_kset->list, entry) {
> +		/* this removes only enumeration atribute group under main_dir_kset */
> +		sysfs_remove_group(pos, &enumeration_attr_group);
> +	}
> +	kfree(enumeration_data);
> +}

As mentioned in the v2 thread I would prefer for this to be done differently
(for all exit_foo_attributes functions).

<snip>

> diff --git a/drivers/platform/x86/dell-wmi-passobj-attributes.c b/drivers/platform/x86/dell-wmi-passobj-attributes.c
> new file mode 100644
> index 000000000000..6884e6153dd6
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-passobj-attributes.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to password object type attributes under BIOS Password Object GUID for
> + * use with dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include "dell-wmi-sysman-attributes.h"
> +
> +enum po_properties {IS_PASS_SET = 1, MIN_PASS_LEN, MAX_PASS_LEN};
> +
> +/* kept variable names same as in sysfs file name for sysfs_show macro definition */
> +struct po_data {
> +	char attribute_name[MAX_BUFF];
> +	int is_password_set;
> +	int min_password_length;
> +	int max_password_length;
> +	char type[MAX_BUFF];
> +};
> +
> +static struct po_data *po_data;
> +static int po_instances_count;
> +get_instance_id(po);
> +
> +static ssize_t is_password_set_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
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
> +		po_data[instance_id].is_password_set =
> +			(uintptr_t)obj->package.elements[IS_PASS_SET].string.pointer;
> +		kfree(obj);
> +		return sprintf(buf, "%d\n", po_data[instance_id].is_password_set);
> +	}
> +	return -EIO;
> +}
> +
> +struct kobj_attribute po_is_pass_set =
> +		__ATTR_RO(is_password_set);
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
> +	if (strlen(buf) > MAX_BUFF)
> +		return -EINVAL;

This check fails to take strlen(buf) == MAX_BUFF into account, in that
case the strncpy below:

> +
> +	if (strcmp(kobj->name, "Admin") == 0)
> +		strncpy(wmi_priv.current_admin_password, buf, (strlen(buf) + 1));

Will write MAX_BUFF + 1 bytes to wmi_priv.current_admin_password !

Looking at the string handling in this driver in general,
I am not really happy with it.

It seems that strncpy is used everywhere and strncpy is a horrible
function, which sreally should never be used. The reason for this
is that the source string having a length greater then the passed
in buffer-length will result in the destination buffer not being
0 terminated. Now sometimes that is a feature, but in that case
you should probably use memcpy to make it clear that you expect
the string to not be 0 terminated.

In other cases using strlcpy is better since it guarantees 0
termination (truncating the input to fit in the destination-buffer).

Now I see that you try to correctly deal with strncpy-s nastiness
everywhere, but please just don't use it all.
Not using strncpy at all is much better.

A lot of the strncpy usage is hidden in:

strncpy_attr(char *dest, char *src)
{
         size_t len = strlen(src) + 1;

         if (len > 1 && len < MAX_BUFF)
                 strncpy(dest, src, len);
}

Why is there no warning printed when the source string
is too long ? Now we just quietly throw away the
data, which seems undesirable.

Also wouldn't truncating the data to fit in MAX_BUFF be better?
(honest question, I do not know which option is better)


> +	if (strcmp(kobj->name, "System") == 0)
> +		strncpy(wmi_priv.current_system_password, buf, (strlen(buf) + 1));
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

Same issue with the length check.

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
> +attribute_s_property_show(type, po);
> +struct kobj_attribute po_type =
> +	__ATTR_RO(type);
> +
> +static struct attribute *po_attrs[] = {
> +	&po_is_pass_set.attr,
> +	&po_min_pass_length.attr,
> +	&po_max_pass_length.attr,
> +	&po_current_password.attr,
> +	&po_new_password.attr,
> +	&po_type.attr,
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
> +	po_instances_count = get_instance_count(DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID);
> +	po_data = kzalloc((sizeof(struct po_data) * po_instances_count), GFP_KERNEL);
> +	if (!po_data)
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
> +	int retval = sysfs_create_group(attr_name_kobj, &po_attr_group);
> +
> +	if (retval)
> +		goto out;
> +
> +	mutex_lock(&wmi_priv.mutex);
> +	strncpy_attr(po_data[instance_id].attribute_name, po_obj[ATTR_NAME].string.pointer);
> +	po_data[instance_id].is_password_set = (uintptr_t)po_obj[IS_PASS_SET].string.pointer;
> +	po_data[instance_id].min_password_length = (uintptr_t)po_obj[MIN_PASS_LEN].string.pointer;
> +	po_data[instance_id].max_password_length = (uintptr_t) po_obj[MAX_PASS_LEN].string.pointer;
> +	strncpy_attr(po_data[instance_id].type, "password_object");
> +	mutex_unlock(&wmi_priv.mutex);
> +
> +out:
> +	return retval;
> +}
> +
> +/**
> + * exit_po_attributes() - Clear all attribute data
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_po_attributes(void)
> +{
> +	struct kobject *pos, *next;
> +
> +	list_for_each_entry_safe(pos, next, &wmi_priv.password_dir_kset->list, entry) {
> +		/* this removes only enumeration atribute group under main_dir_kset */
> +		sysfs_remove_group(pos, &po_attr_group);
> +	}
> +	kfree(po_data);
> +}
> diff --git a/drivers/platform/x86/dell-wmi-passwordattr-interface.c b/drivers/platform/x86/dell-wmi-passwordattr-interface.c
> new file mode 100644
> index 000000000000..bd19d6c15002
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-passwordattr-interface.c
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
> +#include "dell-wmi-sysman-attributes.h"
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

Hmm, I see so there is more then one boolean for user-space to monitor.

I guess that in that case udev change events might make sense.  That would
also be easier to describe in the sysfs API, we can just say that if anything
changes a udev change event is send.

Note you should still make sure to only do the other kobject_uevent() call
on the first change of pending_changes from 0 -> 1, after that it does not
change, so there is no need to spam userspace with more uevents.

Regards,

Hans

