Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124552693DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgINRnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:43:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32459 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726149AbgINMGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600085176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+W75u5DWHV3TIw6qvGbUjvoGTXNyTm9JFT4/6cpQG0=;
        b=XsR24fbDZC+SQa2diIY6OiTMlSy2Pd+Pzcv4KrQhrv3c8KuxvsBJQXi28ehP9fNSJlsUIz
        3rfi+mxZWpgSAV0lGnj/yUP84MPYsfghf8Db0kRytO6lZmCVi5Gu2ItQHqhQL35NrGyeXM
        K/IvhG+Gl24U1io5fzqC/kt+iQbTAUY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-pGmb3MAHMEaQ4KfZeXoWcg-1; Mon, 14 Sep 2020 07:58:06 -0400
X-MC-Unique: pGmb3MAHMEaQ4KfZeXoWcg-1
Received: by mail-wr1-f70.google.com with SMTP id r16so6784427wrm.18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1+W75u5DWHV3TIw6qvGbUjvoGTXNyTm9JFT4/6cpQG0=;
        b=PSJYGut44NUj7J2WW1HHiR54DYiQRFqHj73k6BWWtl0f22YGQIPaJ/g7laqj4BHu1Q
         Af+GgIAOfWfsFYbKZ4ogalSFumpexdFfHezIje00zrftZOVDvjf8qPveWHp1AR1BiAC0
         F7uzeDc/OM7aiEIPYee9aJvLatC8jZwRmqZX62EllD3OW4J5syWfPSD2a7DAJ/sTHMfY
         B4ZsuviDnTj2Ug83UdZMk5SxwHZXUJIm0dKaeOmsLj3vwFvYaGzD8Z9ECwfgBJs5rw7R
         y8pXX6A28pVj7A1zuTeOe2KEUfHQlqAmQm1BbVSHN1gyvg9K1s7Q9hL2VMDFUjjKwh5V
         gXtg==
X-Gm-Message-State: AOAM530yhnBeYIYgiftXlJO53zJiDPHHDXo339/M4vJ4DnnxZLGCPid3
        veBTbgIrKRTG0H7wbY5g/ZTHLnSuVdxq9IQW/lUnM3657UrdW+FpXEBvO0G3vdbKJ1F82f8uhFX
        TIUXhX8VbQBqNmnctiBphGTtQ
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr15512317wrj.110.1600084684244;
        Mon, 14 Sep 2020 04:58:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhYE5HSdrgy5pT7+iBxp3YfmvqYBp/dPPUg64T4sjbRYFpNhnLeOlW2zxpB2hX6Nqp5hGApA==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr15512270wrj.110.1600084683593;
        Mon, 14 Sep 2020 04:58:03 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id c14sm13158089wrm.64.2020.09.14.04.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 04:58:02 -0700 (PDT)
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
Message-ID: <aaf3b072-a109-4f69-67dd-bea3dc5fb023@redhat.com>
Date:   Mon, 14 Sep 2020 13:58:02 +0200
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
this second email focusses on the code.

Note I'm still mainly focusing on the overall
structure and how you handle locking here.

Further reviews (of newer versions) will look
at the per function code in more detail.

On 9/4/20 4:28 PM, Divya Bharathi wrote:
> diff --git a/drivers/platform/x86/dell-wmi-biosattr-interface.c b/drivers/platform/x86/dell-wmi-biosattr-interface.c
> new file mode 100644
> index 000000000000..dda38d448fec
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-biosattr-interface.c
> @@ -0,0 +1,198 @@
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
> +#include "dell-wmi-sysman-attributes.h"
> +
> +#define SETDEFAULTVALUES_METHOD_ID					0x02
> +#define SETBIOSDEFAULTS_METHOD_ID					0x03
> +#define SETATTRIBUTE_METHOD_ID						0x04
> +
> +static DEFINE_MUTEX(call_mutex);

By doing this you still declare one lock per file, so code from 2 files could
be accessing the wmi_priv struct and be making WMI calls at the same time.

Please add a mutex to the dell_wmi_sysman_priv struct, like this:

In dell-wmi-sysman-attributes.h:

struct dell_wmi_sysman_priv {
	struct mutex mutex;
         char current_admin_password[MAX_BUFF];
         char current_system_password[MAX_BUFF];
         struct wmi_device *password_attr_wdev;
         struct wmi_device *bios_attr_wdev;
         bool pending_changes;
};

And in dell-wmi-sysman-attributes.c:

struct dell_wmi_sysman_priv wmi_priv = {
	.mutex = __MUTEX_INITIALIZER(wmi_priv.mutex),
};

And then whenever you need the mutex call:

	mutex_lock(&wmi_priv.mutex);
	...
	mutex_unlock(&wmi_priv.mutex);

And use this in all files.

> +extern struct dell_wmi_sysman_priv wmi_priv;

Please move this to dell-wmi-sysman-attributes.h .


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
> +	kfree(output.pointer);
> +	kobject_uevent(&wdev->dev.kobj, KOBJ_CHANGE);

Why are you generating an uevent here? I think this needs a comment (or it should be removed).

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
> +	char *buffer;
> +	int ret;
> +
> +	/* build/calculate buffer */
> +	security_area_size = calculate_security_buffer();
> +	string_area_size = (strlen(a_name) + strlen(a_value))*2;
> +	buffer_size = security_area_size + string_area_size + sizeof(u16) * 2;
> +	buffer = kzalloc(buffer_size, GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;
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
> +		pr_err("UTF16 conversion failed");
> +		goto out_set_attribute;
> +	}
> +
> +	value_len = (u8 *) attribute_name + *name_len;
> +	attribute_value = value_len + sizeof(u16);
> +	*value_len = utf8s_to_utf16s(a_value, strlen(a_value), UTF16_HOST_ENDIAN,
> +				    (wchar_t *) attribute_value, MAX_BUFF) * 2;
> +	if (*value_len < 0) {
> +		ret = -EINVAL;
> +		pr_err("UTF16 conversion failed");
> +		goto out_set_attribute;
> +	}
> +
> +	mutex_lock(&call_mutex);
> +	if (!wmi_priv.bios_attr_wdev) {
> +		ret = -ENODEV;
> +		pr_err("no WMI backend bound");
> +		goto out_set_attribute;
> +	}

It is probably better to move this to the top, as I mentioned in my reply
to Mario, you could add something like this to the top of each function,
even before allocating the buffer and filling it.

     mutex_lock(&wmi_priv.mutex);

     if (!wmi_priv.bios_attr_wdev || !wmi_priv.password_attr_wdev) {
         ret = -ENODEV;
         goto out_set_attribute;
     }

Note this requires that you initialize the buf pointer to NULL
wehn declaring it.

Having this at the top of each function establishes a pattern where
it easy for a reader of the code to:

a) See that the check is present when checking that the driver being
unbound is checked everywhere

b) Ignore the check as "boilerplate" when looking at other parts of
the code

Also note that I dropped the pr_err. Users should not go around and
unbind drivers, if they then we should not crash. But the user asked
for it, so just returning -ENODEV without logging an error should be
fine.


> +
> +	ret = call_biosattributes_interface(wmi_priv.bios_attr_wdev,
> +					    buffer, buffer_size,
> +					    SETATTRIBUTE_METHOD_ID);
> +	if (ret == -EOPNOTSUPP)
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "admin password must be configured");
> +	else if (ret == -EACCES)
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "invalid password");
> +
> +	wmi_priv.pending_changes = 1;
> +out_set_attribute:
> +	kfree(buffer);
> +	mutex_unlock(&call_mutex);
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
> +	u8 *defaultType;
> +	char *buffer;
> +	int ret;
> +

You are missing the check for the driver being unbound here,
this nicely documents why you should have this at the top
of each function making WMI calls.

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
> +	mutex_lock(&call_mutex);
> +	if (!wmi_priv.bios_attr_wdev) {
> +		ret = -ENODEV;
> +		pr_err("no WMI backend bound");
> +		goto out_bios_defaults;
> +	}
> +
> +	defaultType = buffer + security_area_size;
> +	*defaultType = deftype;
> +
> +	ret = call_biosattributes_interface(wmi_priv.bios_attr_wdev, buffer, buffer_size,
> +					    SETBIOSDEFAULTS_METHOD_ID);
> +	if (ret)
> +		dev_err(&wmi_priv.bios_attr_wdev->dev, "reset BIOS defaults failed: %d", ret);
> +	wmi_priv.pending_changes = 1;
> +out_bios_defaults:
> +	kfree(buffer);
> +	mutex_unlock(&call_mutex);
> +
> +	return ret;
> +}
> +
> +static int dell_wmi_bios_attr_set_interface_probe(struct wmi_device *wdev, const void *context)
> +{
> +	wmi_priv.bios_attr_wdev = wdev;
> +	return 0;
> +}
> +
> +static int dell_wmi_bios_attr_set_interface_remove(struct wmi_device *wdev)
> +{
> +	mutex_lock(&call_mutex);
> +	wmi_priv.bios_attr_wdev = NULL;
> +	mutex_unlock(&call_mutex);
> +	return 0;
> +}
> +
> +static const struct wmi_device_id dell_wmi_bios_attr_set_interface_id_table[] = {
> +	{ .guid_string = DELL_WMI_BIOS_ATTRIBUTES_INTERFACE_GUID },
> +	{ },
> +};
> +static struct wmi_driver dell_wmi_bios_attr_set_interface_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME"-set"
> +	},
> +	.probe = dell_wmi_bios_attr_set_interface_probe,
> +	.remove = dell_wmi_bios_attr_set_interface_remove,
> +	.id_table = dell_wmi_bios_attr_set_interface_id_table,
> +};
> +
> +int init_dell_wmi_bios_attr_set_interface(void)
> +{
> +	return wmi_driver_register(&dell_wmi_bios_attr_set_interface_driver);
> +}
> +
> +void exit_dell_wmi_bios_attr_set_interface(void)
> +{
> +	wmi_driver_unregister(&dell_wmi_bios_attr_set_interface_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(wmi, dell_wmi_bios_attr_set_interface_id_table);
> diff --git a/drivers/platform/x86/dell-wmi-enum-attributes.c b/drivers/platform/x86/dell-wmi-enum-attributes.c
> new file mode 100644
> index 000000000000..f2370f067b6d
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-enum-attributes.c
> @@ -0,0 +1,214 @@
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
> +static DEFINE_MUTEX(enum_mutex);
> +extern struct mutex kset_mutex;

Please just use the global wmi_priv.mutex to replace both of these.

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
> +	int possible_value_count;
> +	char possible_value[MAX_BUFF];
> +	char type[MAX_BUFF];
> +};
> +
> +static struct enumeration_data *enumeration_data;
> +static int enumeration_instances_count;

Please store these 2 in the global wmi_priv data.

Also there is a lot of overlap between structs like
struct enumeration_data, struct integer_data, etc.

I think it would be good to make a single struct
attr_data, which contains fields for all the
supported types.

I also see a lot of overlapping code between:

drivers/platform/x86/dell-wmi-enum-attributes.c
drivers/platform/x86/dell-wmi-int-attributes.c
drivers/platform/x86/dell-wmi-string-attributes.c

I think that folding the data structures together
will help with also unifying that code into a
single dell-wmi-std-attributes.c file.

> +get_instance_id(enumeration);
> +
> +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int instance_id;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +	instance_id = get_enumeration_instance_id(kobj);

If you unify the integer, string and enum code then this just becomes:
get_std_instance_id(kobj)

> +	if (instance_id >= 0) {
> +		union acpi_object *obj;
> +
> +		obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
> +		if (!obj)
> +			return -AE_ERROR;

> +		strncpy_attr(enumeration_data[instance_id].current_value,
> +		       obj->package.elements[CURRENT_VAL].string.pointer);
So these 2 lines seem to be the only thing which is different for current_value_show,
between enums, ints and strings, so you can put a simple switch-case on the type here.

> +		kfree(obj);
> +		return sprintf(buf, "%s\n", enumeration_data[instance_id].current_value);
> +	}
> +	return -EIO;
> +} > +
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
> +	options = tmp = kstrdup((enumeration_data[instance_id].possible_value), GFP_KERNEL);
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

For the validate functions you can keep all 3 in the new
dell-wmi-std-attributes.c file and then call the right one through a
switch-case based on the type.

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
> +attribute_s_property_show(possible_value, enumeration);
> +struct kobj_attribute poss_val =
> +		__ATTR_RO(possible_value);
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
> +	if (!enumeration_data)
> +		ret = -ENOMEM;
> +	return ret;
> +}
> +

The rest of the file is mostly identical between strings, ints and enums.

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
> +	int i, next_obj;
> +
> +	if (retval)
> +		goto out;
> +
> +	mutex_lock(&enum_mutex);
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
> +	enumeration_data[instance_id].possible_value_count =
> +		(uintptr_t) enumeration_obj[++next_obj].string.pointer;
> +
> +	for (i = 0; i < enumeration_data[instance_id].possible_value_count; i++) {
> +		strcat(enumeration_data[instance_id].possible_value,
> +			enumeration_obj[++next_obj].string.pointer);
> +		strcat(enumeration_data[instance_id].possible_value, ";");
> +	}
> +	strncpy_attr(enumeration_data[instance_id].type, "enumeration");
> +	mutex_unlock(&enum_mutex);
> +
> +out:
> +	return retval;
> +}


I guess you may also need a switch-case based on the
type in the populare function.

> +
> +/**
> + * exit_enum_attributes() - Clear all attribute data
> + * @kset: The kset to free
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_enum_attributes(struct kset *kset)
> +{
> +	struct kobject *pos, *next;
> +
> +	mutex_lock(&kset_mutex);
> +	list_for_each_entry_safe(pos, next, &kset->list, entry) {
> +		sysfs_remove_group(pos, &enumeration_attr_group);
> +	}
> +	mutex_unlock(&kset_mutex);
> +	mutex_lock(&enum_mutex);
> +	kfree(enumeration_data);
> +	mutex_unlock(&enum_mutex);
> +}

Since there is now only 1 kset for the main dir, you are now
calling sysfs_remove_group 4 times (for all the different times)
on each entry in the attributes dir. I guess this may fail silently,
but it still is not good. So this needs to be fixed.

The remarks to this file also apply to the:

drivers/platform/x86/dell-wmi-int-attributes.c
drivers/platform/x86/dell-wmi-string-attributes.c

files.

> diff --git a/drivers/platform/x86/dell-wmi-int-attributes.c b/drivers/platform/x86/dell-wmi-int-attributes.c
> new file mode 100644
> index 000000000000..d922d4f73ce9
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-int-attributes.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to integer type attributes under BIOS Integer GUID for use with
> + * dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include "dell-wmi-sysman-attributes.h"
> +
> +static DEFINE_MUTEX(int_mutex);
> +extern struct mutex kset_mutex;
> +
> +enum int_properties {LOWER_BOUND = 6, UPPER_BOUND, SCALAR_INCR};
> +
> +/* kept variable names same as in sysfs file name for sysfs_show macro definition */
> +struct integer_data {
> +	char display_name_language_code[MAX_BUFF];
> +	char attribute_name[MAX_BUFF];
> +	char display_name[MAX_BUFF];
> +	int default_value;
> +	int current_value;
> +	char modifier[MAX_BUFF];
> +	int lower_bound;
> +	int upper_bound;
> +	int scalar_increment;
> +	char type[MAX_BUFF];
> +};
> +
> +static struct integer_data *integer_data;
> +static int integer_instances_count;
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
> +		obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
> +		if (!obj)
> +			return -AE_ERROR > +		integer_data[instance_id].current_value =
> +			(uintptr_t)obj->package.elements[CURRENT_VAL].string.pointer;
> +		kfree(obj);
> +		return sprintf(buf, "%d\n", integer_data[instance_id].current_value);
> +	}
> +	return -EIO;
> +} > +
> +/**
> + * validate_integer_input() - Validate input of current_value against lower and upper bound
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + **/
> +int validate_integer_input(int instance_id, const char *buf)
> +{
> +	int ret = -EINVAL;
> +	int in_val;
> +
> +	if (kstrtoint(buf, 0, &in_val))
> +		return ret;
> +	if ((in_val >= integer_data[instance_id].lower_bound) &&
> +	(in_val <= integer_data[instance_id].upper_bound))
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
> +struct kobj_attribute integer_displ_name =
> +	__ATTR_RO(display_name);
> +
> +attribute_n_property_show(default_value, integer);
> +struct kobj_attribute integer_default_val =
> +	__ATTR_RO(default_value);
> +
> +attribute_property_store(current_value, integer);
> +struct kobj_attribute integer_current_val =
> +	__ATTR_RW(current_value);
> +
> +attribute_s_property_show(modifier, integer);
> +struct kobj_attribute integer_modifier =
> +	__ATTR_RO(modifier);
> +
> +attribute_n_property_show(lower_bound, integer);
> +struct kobj_attribute integer_lower_bound =
> +	__ATTR_RO(lower_bound);
> +
> +attribute_n_property_show(upper_bound, integer);
> +struct kobj_attribute integer_upper_bound =
> +	__ATTR_RO(upper_bound);
> +
> +attribute_n_property_show(scalar_increment, integer);
> +struct kobj_attribute integer_scalar_increment =
> +	__ATTR_RO(scalar_increment);
> +
> +attribute_s_property_show(type, integer);
> +struct kobj_attribute integer_type =
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
> +	integer_instances_count = get_instance_count(DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
> +	integer_data = kzalloc((sizeof(struct integer_data) * integer_instances_count), GFP_KERNEL);
> +	if (!integer_data)
> +		ret = -ENOMEM;
> +	return ret;
> +}
> +
> +/**
> + * populate_enum_data() - Populate all properties of an instance under integer attribute
> + * @integer_obj: ACPI object with integer data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + **/
> +int populate_int_data(union acpi_object *integer_obj, int instance_id,
> +			struct kobject *attr_name_kobj)
> +{
> +	int retval = sysfs_create_group(attr_name_kobj, &integer_attr_group);
> +
> +	if (retval)
> +		goto out;
> +
> +	mutex_lock(&int_mutex);
> +	strncpy_attr(integer_data[instance_id].attribute_name,
> +		integer_obj[ATTR_NAME].string.pointer);
> +	strncpy_attr(integer_data[instance_id].display_name_language_code,
> +		integer_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	strncpy_attr(integer_data[instance_id].display_name,
> +		integer_obj[DISPLAY_NAME].string.pointer);
> +	integer_data[instance_id].default_value =
> +		(uintptr_t)integer_obj[DEFAULT_VAL].string.pointer;
> +	integer_data[instance_id].current_value =
> +		(uintptr_t)integer_obj[CURRENT_VAL].string.pointer;
> +	strncpy_attr(integer_data[instance_id].modifier, integer_obj[MODIFIER].string.pointer);
> +	integer_data[instance_id].lower_bound =
> +		(uintptr_t)integer_obj[LOWER_BOUND].string.pointer;
> +	integer_data[instance_id].upper_bound =
> +		(uintptr_t)integer_obj[UPPER_BOUND].string.pointer;
> +	integer_data[instance_id].scalar_increment =
> +		(uintptr_t)integer_obj[SCALAR_INCR].string.pointer;
> +	strncpy_attr(integer_data[instance_id].type, "integer");
> +	mutex_unlock(&int_mutex);
> +
> +out:
> +	return retval;
> +}
> +
> +/**
> + * exit_int_attributes() - Clear all attribute data
> + * @kset: The kset to free
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_int_attributes(struct kset *kset)
> +{
> +	struct kobject *pos, *next;
> +
> +	mutex_lock(&kset_mutex);
> +	list_for_each_entry_safe(pos, next, &kset->list, entry) {
> +		sysfs_remove_group(pos, &integer_attr_group);
> +	}
> +	mutex_unlock(&kset_mutex);
> +	mutex_lock(&int_mutex);
> +	kfree(integer_data);
> +	mutex_unlock(&int_mutex);
> +}
> diff --git a/drivers/platform/x86/dell-wmi-passobj-attributes.c b/drivers/platform/x86/dell-wmi-passobj-attributes.c
> new file mode 100644
> index 000000000000..87bb7772bb18
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-passobj-attributes.c
> @@ -0,0 +1,168 @@
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
> +static DEFINE_MUTEX(po_mutex);
> +extern struct mutex kset_mutex;
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
> +
> +	ret = set_current_password(kobj->name, buf);
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

So these don't have a current_value, display_name, etc. standard sysfs entries,
so maybe put the passwords in a separate:
/sys/devices/platform/dell-wmi-sysman/passwords

Dir, otherwise saying that all attributes have a current_value, display_name, etc.
in the sysfs ABI documentation is incorrect. Doing this also gives you 2 dirs / ksets
for the cleanup, 1 for all std attributes and 1 for passwords which also solves
the cleanup problem I pointed out above.

Having 2 dirs, 1 for normal attributes and 1 for passwords, also matches the
2 WMI interfaces, so I believe that this is the right way to go.


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
> +	mutex_lock(&po_mutex);
> +	strncpy_attr(po_data[instance_id].attribute_name, po_obj[ATTR_NAME].string.pointer);
> +	po_data[instance_id].is_password_set = (uintptr_t)po_obj[IS_PASS_SET].string.pointer;
> +	po_data[instance_id].min_password_length = (uintptr_t)po_obj[MIN_PASS_LEN].string.pointer;
> +	po_data[instance_id].max_password_length = (uintptr_t) po_obj[MAX_PASS_LEN].string.pointer;
> +	strncpy_attr(po_data[instance_id].type, "password_object");
> +	mutex_unlock(&po_mutex);
> +
> +out:
> +	return retval;
> +}
> +
> +/**
> + * exit_po_attributes() - Clear all attribute data
> + * @kset: The kset to free
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_po_attributes(struct kset *kset)
> +{
> +	struct kobject *pos, *next;
> +
> +	mutex_lock(&kset_mutex);
> +	list_for_each_entry_safe(pos, next, &kset->list, entry) {
> +		sysfs_remove_group(pos, &po_attr_group);
> +	}
> +	mutex_unlock(&kset_mutex);
> +	mutex_lock(&po_mutex);
> +	kfree(po_data);
> +	mutex_unlock(&po_mutex);
> +}
> diff --git a/drivers/platform/x86/dell-wmi-passwordattr-interface.c b/drivers/platform/x86/dell-wmi-passwordattr-interface.c
> new file mode 100644
> index 000000000000..d105608cbb86
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-passwordattr-interface.c
> @@ -0,0 +1,200 @@
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
> +static DEFINE_MUTEX(call_mutex);
> +extern struct dell_wmi_sysman_priv wmi_priv;

See my comments on drivers/platform/x86/dell-wmi-biosattr-interface.c about this.

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
> +	kobject_uevent(&wdev->dev.kobj, KOBJ_CHANGE);
> +	return map_wmi_error(ret);
> +}
> +
> +/**
> + * get_current_password() - Get the current stored password value
> + * @password_type: The type of password to store
> + **/
> +static char *get_current_password(const char *password_type)
> +{
> +	if (strcmp(password_type, "Admin") == 0)
> +		return wmi_priv.current_admin_password;
> +	if (strcmp(password_type, "System") == 0)
> +		return wmi_priv.current_system_password;
> +	dev_err(&wmi_priv.password_attr_wdev->dev, "unknown password type %s", password_type);
> +	return NULL;
> +}

Since you have the passwords directly available in wmi_priv now this
function seems no longer necessary ?

> +
> +/**
> + * set_current_password() - Store current password
> + * @password_type: The type of password to store
> + * @current: The current value
> + *
> + * Sets the current value of the password.
> + * This is used for:
> + *  - Resetting password
> + *  - Basis for any functions requiring password to execute
> + **/
> +int set_current_password(const char *password_type, const char *cur)
> +{
> +	char *current_password = get_current_password(password_type);
> +
> +	if (!current_password)
> +		return -ENODEV;
> +	strncpy(current_password, cur, (strlen(cur) + 1));
> +	return 0;
> +}

Same.

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
> +	char *buffer;
> +	int ret;
> +
> +	/* only allow one password set at a time */

This comment is somewhat confusing, I guess it is meant for the
mutex_lock call, but the mutex e.g. also protects wmi_priv.password_attr_wdev
from changing while this code is running, please drop the comment.

> +	mutex_lock(&call_mutex);
> +	if (!wmi_priv.password_attr_wdev) {
> +		ret = -ENODEV;
> +		pr_err("no WMI backend bound");
> +		goto out_close_mutex;
> +	}
> +	current_password = get_current_password(password_type);
> +	if (!current_password) {
> +		ret = -ENODEV;
> +		goto out_close_mutex;
> +	}
> +
> +	/* build/calculate buffer */
> +	security_area_size = calculate_security_buffer();
> +	string_area_size = (strlen(password_type) + strlen(current_password) + strlen(new))*2;
> +	buffer_size = security_area_size + string_area_size + sizeof(u16) * 3;
> +	buffer = kzalloc(buffer_size, GFP_KERNEL);
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto out_close_mutex;
> +	}
> +
> +	/* build security area */
> +	if (strlen(current_password) > 0)
> +		populate_security_buffer(buffer, current_password);
> +
> +	/* build variables to set */
> +	type_len = buffer + security_area_size;
> +	type_value = type_len + sizeof(u16);
> +	*type_len = utf8s_to_utf16s(password_type, strlen(password_type), UTF16_HOST_ENDIAN,
> +				    (wchar_t *) type_value, MAX_BUFF) * 2;
> +	if (*type_len < 0) {
> +		ret = -EINVAL;
> +		pr_err("UTF16 conversion failed");
> +		goto out_cleanup;
> +	}
> +
> +	old_len = type_value + *type_len;
> +	old_value = old_len + sizeof(u16);
> +	*old_len = utf8s_to_utf16s(current_password, strlen(current_password), UTF16_HOST_ENDIAN,
> +				   (wchar_t *) old_value, MAX_BUFF) * 2;
> +	if (*old_len < 0) {
> +		ret = -EINVAL;
> +		pr_err("UTF16 conversion failed");
> +		goto out_cleanup;
> +	}
> +
> +	new_len = old_value + *old_len;
> +	new_value = new_len + sizeof(u16);
> +	*new_len = utf8s_to_utf16s(new, strlen(new), UTF16_HOST_ENDIAN,
> +				   (wchar_t *) new_value, MAX_BUFF) * 2;
> +	if (*new_len < 0) {
> +		ret = -EINVAL;
> +		pr_err("UTF16 conversion failed");
> +		goto out_cleanup;
> +	}
> +
> +	ret = call_password_interface(wmi_priv.password_attr_wdev, buffer, buffer_size);
> +	/* update current password so commands work after reset */
> +	if (!ret)
> +		ret = set_current_password(password_type, new);
> +	/* explain to user the detailed failure reason */
> +	else if (ret == -EOPNOTSUPP)
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "admin password must be configured");
> +	else if (ret == -EACCES)
> +		dev_err(&wmi_priv.password_attr_wdev->dev, "invalid password");
> +
> +out_cleanup:
> +	kfree(buffer);
> +
> +out_close_mutex:
> +	mutex_unlock(&call_mutex);

You don't need 2 separate out_foo labels, kfree(NULL) is a no-op, so
if you initialize buffer to NULL when you declare it you can use a single
out label.

> +
> +	return ret;
> +}
> +
> +static int dell_wmi_bios_attr_pass_interface_probe(struct wmi_device *wdev, const void *context)
> +{
> +	wmi_priv.password_attr_wdev = wdev;
> +	return 0;
> +}
> +
> +static int dell_wmi_bios_attr_pass_interface_remove(struct wmi_device *wdev)
> +{
> +	mutex_lock(&call_mutex);
> +	wmi_priv.password_attr_wdev = NULL;
> +	mutex_unlock(&call_mutex);
> +	return 0;
> +}
> +
> +static const struct wmi_device_id dell_wmi_bios_attr_pass_interface_id_table[] = {
> +	{ .guid_string = DELL_WMI_BIOS_PASSWORD_INTERFACE_GUID },
> +	{ },
> +};
> +static struct wmi_driver dell_wmi_bios_attr_pass_interface_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME"-password"
> +	},
> +	.probe = dell_wmi_bios_attr_pass_interface_probe,
> +	.remove = dell_wmi_bios_attr_pass_interface_remove,
> +	.id_table = dell_wmi_bios_attr_pass_interface_id_table,
> +};
> +
> +int init_dell_wmi_bios_attr_pass_interface(void)
> +{
> +	return wmi_driver_register(&dell_wmi_bios_attr_pass_interface_driver);
> +}
> +
> +void exit_dell_wmi_bios_attr_pass_interface(void)
> +{
> +	wmi_driver_unregister(&dell_wmi_bios_attr_pass_interface_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(wmi, dell_wmi_bios_attr_pass_interface_id_table);
> diff --git a/drivers/platform/x86/dell-wmi-string-attributes.c b/drivers/platform/x86/dell-wmi-string-attributes.c
> new file mode 100644
> index 000000000000..397de6fb13a3
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-string-attributes.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to string type attributes under BIOS String GUID for use with
> + * dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include "dell-wmi-sysman-attributes.h"
> +
> +static DEFINE_MUTEX(str_mutex);
> +extern struct mutex kset_mutex;
> +
> +enum string_properties {MIN_LEN = 6, MAX_LEN};
> +
> +/* kept variable names same as in sysfs file name for sysfs_show macro definition */
> +struct str_data {
> +	char display_name_language_code[MAX_BUFF];
> +	char attribute_name[MAX_BUFF];
> +	char display_name[MAX_BUFF];
> +	char default_value[MAX_BUFF];
> +	char current_value[MAX_BUFF];
> +	char modifier[MAX_BUFF];
> +	int min_length;
> +	int max_length;
> +	char type[MAX_BUFF];
> +};
> +
> +static struct str_data *str_data;
> +static int str_instances_count;
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
> +		obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
> +		if (!obj)
> +			return -AE_ERROR;
> +		strncpy_attr(str_data[instance_id].current_value,
> +			obj->package.elements[CURRENT_VAL].string.pointer);
> +		kfree(obj);
> +		return sprintf(buf, "%s\n", str_data[instance_id].current_value);
> +	}
> +	return -EIO;
> +}
> +
> +/**
> + * validate_str_input() - Validate input of current_value against min and max lengths
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + **/
> +int validate_str_input(int instance_id, const char *buf)
> +{
> +	int in_len = strlen(buf);
> +
> +	if ((in_len >= str_data[instance_id].min_length) &&
> +	(in_len <= str_data[instance_id].max_length))
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
> +struct kobj_attribute str_displ_name =
> +		__ATTR_RO(display_name);
> +
> +attribute_s_property_show(default_value, str);
> +struct kobj_attribute str_default_val =
> +		__ATTR_RO(default_value);
> +
> +attribute_property_store(current_value, str);
> +struct kobj_attribute str_current_val =
> +		__ATTR_RW(current_value);
> +
> +attribute_s_property_show(modifier, str);
> +struct kobj_attribute str_modifier =
> +		__ATTR_RO(modifier);
> +
> +attribute_n_property_show(min_length, str);
> +struct kobj_attribute str_min_length =
> +		__ATTR_RO(min_length);
> +
> +attribute_n_property_show(max_length, str);
> +struct kobj_attribute str_max_length =
> +		__ATTR_RO(max_length);
> +
> +attribute_s_property_show(type, str);
> +struct kobj_attribute str_type =
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
> +	str_instances_count = get_instance_count(DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
> +	str_data = kzalloc((sizeof(struct str_data) * str_instances_count), GFP_KERNEL);
> +	if (!str_data)
> +		ret = -ENOMEM;
> +	return ret;
> +}
> +
> +/**
> + * populate_enum_data() - Populate all properties of an instance under string attribute
> + * @str_obj: ACPI object with integer data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + **/
> +int populate_str_data(union acpi_object *str_obj, int instance_id, struct kobject *attr_name_kobj)
> +{
> +	int retval = sysfs_create_group(attr_name_kobj, &str_attr_group);
> +
> +	if (retval)
> +		goto out;
> +
> +	mutex_lock(&str_mutex);
> +	strncpy_attr(str_data[instance_id].attribute_name, str_obj[ATTR_NAME].string.pointer);
> +	strncpy_attr(str_data[instance_id].display_name_language_code,
> +		str_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	strncpy_attr(str_data[instance_id].display_name, str_obj[DISPLAY_NAME].string.pointer);
> +	strncpy_attr(str_data[instance_id].default_value, str_obj[DEFAULT_VAL].string.pointer);
> +	strncpy_attr(str_data[instance_id].current_value, str_obj[CURRENT_VAL].string.pointer);
> +	strncpy_attr(str_data[instance_id].modifier, str_obj[MODIFIER].string.pointer);
> +	str_data[instance_id].min_length = (uintptr_t)str_obj[MIN_LEN].string.pointer;
> +	str_data[instance_id].max_length = (uintptr_t) str_obj[MAX_LEN].string.pointer;
> +	strncpy_attr(str_data[instance_id].type, "string");
> +	mutex_unlock(&str_mutex);
> +
> +out:
> +	return retval;
> +}
> +
> +/**
> + * exit_str_attributes() - Clear all attribute data
> + * @kset: The kset to free
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_str_attributes(struct kset *kset)
> +{
> +	struct kobject *pos, *next;
> +
> +	mutex_lock(&kset_mutex);
> +	list_for_each_entry_safe(pos, next, &kset->list, entry) {
> +		sysfs_remove_group(pos, &str_attr_group);
> +	}
> +	mutex_unlock(&kset_mutex);
> +	mutex_lock(&str_mutex);
> +	kfree(str_data);
> +	mutex_unlock(&str_mutex);
> +}
> diff --git a/drivers/platform/x86/dell-wmi-sysman-attributes.c b/drivers/platform/x86/dell-wmi-sysman-attributes.c
> new file mode 100644
> index 000000000000..139d8f5d3d8e
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman-attributes.c
> @@ -0,0 +1,572 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common methods for use with dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/dmi.h>
> +#include <linux/wmi.h>
> +#include "dell-wmi-sysman-attributes.h"
> +
> +DEFINE_MUTEX(kset_mutex);
> +
> +#define MAX_TYPES  4
> +
> +static struct platform_device *platform_device;
> +
> +static struct platform_driver platform_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +	},
> +};
> +
> +/* global structure used by multiple WMI interfaces */
> +struct dell_wmi_sysman_priv wmi_priv;
> +
> +/* attribute directory under platform dev */
> +struct kset *main_dir_kset;
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
> +	strncpy(auth, authentication, *seclen);
> +}
> +
> +/**
> + * map_wmi_error() - map errors from WMI methods to kernel error codes
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
> +	dev_dbg(&platform_device->dev, "reset all attributes request type %d: %d", type, ret);
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
> +	int ret = sysfs_create_file(&main_dir_kset->kobj, &reset_bios.attr);
> +
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "could not create reset_bios file");
> +		return ret;
> +	}
> +
> +	ret = sysfs_create_file(&main_dir_kset->kobj, &pending_reboot.attr);
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "could not create changing_pending_reboot file");
> +		sysfs_remove_file(&main_dir_kset->kobj, &reset_bios.attr);
> +	}
> +	return ret;
> +}
> +
> +static void release_reset_bios_data(void)
> +{
> +	sysfs_remove_file(&main_dir_kset->kobj, &reset_bios.attr);
> +	sysfs_remove_file(&main_dir_kset->kobj, &pending_reboot.attr);
> +}
> +
> +static ssize_t kobj_attr_show(struct kobject *kobj, struct attribute *attr,
> +			      char *buf)
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
> +static ssize_t kobj_attr_store(struct kobject *kobj, struct attribute *attr,
> +			       const char *buf, size_t count)
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
> +const struct sysfs_ops kobj_sysfs_ops = {
> +	.show	= kobj_attr_show,
> +	.store	= kobj_attr_store,
> +};
> +
> +static void attr_name_release(struct kobject *kobj)
> +{
> +	kfree(kobj);
> +}
> +
> +static struct kobj_type attr_name_ktype = {
> +	.release	= attr_name_release,
> +	.sysfs_ops	= &kobj_sysfs_ops,
> +};
> +
> +/**
> + * strncpy_attr - Copy a length-limited, NULL-terminated string with bound checks
> + * @dest: Where to copy the string to
> + * @src: Where to copy the string from
> + **/
> +void strncpy_attr(char *dest, char *src)
> +{
> +	size_t len = strlen(src) + 1;
> +
> +	if (len > 1 && len < MAX_BUFF)
> +		strncpy(dest, src, len);
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
> +	mutex_lock(&kset_mutex);
> +	list_for_each_entry_safe(pos, next, &kset->list, entry) {
> +		kobject_put(pos);
> +	}
> +	mutex_unlock(&kset_mutex);
> +}
> +
> +/**
> + * release_attributes_data() - Clean-up all sysfs directories and files created
> + **/
> +static void release_attributes_data(void)
> +{
> +	release_reset_bios_data();
> +
> +	exit_enum_attributes(main_dir_kset);
> +	exit_int_attributes(main_dir_kset);
> +	exit_str_attributes(main_dir_kset);
> +	exit_po_attributes(main_dir_kset);
> +
> +	if (main_dir_kset) {
> +		destroy_attribute_objs(main_dir_kset);
> +		kset_unregister(main_dir_kset);
> +	}

Why are the above 2 calls protected with a "if (main_dir_kset)" and the
other 4 calls, which also take main_dir_kset as an argument not ?

Can we ever get here with main_dir_kset == NULL ?

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
> +	int instance_id = 0;
> +	int retval = 0;
> +
> +	retval = alloc_attributes_data(attr_type);
> +	if (retval)
> +		return retval;
> +	obj = get_wmiobj_pointer(instance_id, guid);
> +	if (!obj)
> +		return -ENODEV;
> +	elements = obj->package.elements;
> +
> +	while (elements) {
> +		/* sanity checking */
> +		if (strlen(elements[ATTR_NAME].string.pointer) == 0) {
> +			dev_dbg(&platform_device->dev, "empty attribute found");
> +			goto nextobj;
> +		}
> +		if (kset_find_obj(main_dir_kset, elements[ATTR_NAME].string.pointer)) {
> +			dev_dbg(&platform_device->dev, "duplicate attribute name found - %s",
> +				elements[ATTR_NAME].string.pointer);
> +			goto nextobj;
> +		}
> +
> +		/* build attribute */
> +		attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
> +		if (!attr_name_kobj)
> +			goto err_attr_init;
> +
> +		attr_name_kobj->kset = main_dir_kset;
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
> +			dev_dbg(&platform_device->dev, "failed to populate %s",
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
> +	return retval;
> +}
> +
> +static int __init init_dell_bios_attrib_wmi(void)
> +{
> +	int ret = 0;
> +
> +	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> +	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
> +		pr_err("Unable to run on non-Dell system\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = init_dell_wmi_bios_attr_set_interface();
> +	if (ret || !wmi_priv.bios_attr_wdev) {
> +
> +		dev_dbg(&platform_device->dev, "failed to initialize set interface");
> +		goto fail_set_interface;
> +	}
> +
> +	ret = init_dell_wmi_bios_attr_pass_interface();
> +	if (ret || !wmi_priv.password_attr_wdev) {
> +		dev_dbg(&platform_device->dev, "failed to initialize pass interface");
> +		goto fail_pass_interface;
> +	}
> +
> +	ret = platform_driver_register(&platform_driver);
> +	if (ret)
> +		goto fail_platform_driver;
> +
> +	platform_device = platform_device_alloc(DRIVER_NAME, -1);
> +	if (!platform_device) {
> +		ret = -ENOMEM;
> +		goto fail_platform_device_alloc;
> +	}
> +
> +	ret = platform_device_add(platform_device);
> +	if (ret)
> +		goto fail_platform_device_add;
> +
> +	main_dir_kset = kset_create_and_add("attributes", NULL, &platform_device->dev.kobj);
> +	if (!main_dir_kset) {
> +		ret = -ENOMEM;
> +		goto fail_platform_device_add;
> +	}
> +
> +	ret = create_reset_bios();
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "could not create reset BIOS attribute");
> +		goto fail_kset;
> +	}
> +
> +	ret = init_bios_attributes(ENUM, DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "failed to populate enumeration type attributes");
> +		goto fail_create_group;
> +	}
> +
> +	ret = init_bios_attributes(INT, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "failed to populate integer type attributes");
> +		goto fail_create_group;
> +	}
> +
> +	ret = init_bios_attributes(STR, DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "failed to populate string type attributes");
> +		goto fail_create_group;
> +	}
> +
> +	ret = init_bios_attributes(PO, DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID);
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "failed to populate pass object type attributes");
> +		goto fail_create_group;
> +	}
> +
> +	return 0;
> +
> +fail_create_group:
> +	release_attributes_data();
> +	platform_device_del(platform_device);
> +
> +fail_kset:
> +	kset_unregister(main_dir_kset);
> +
> +fail_platform_device_add:
> +	platform_device_put(platform_device);
> +
> +fail_platform_device_alloc:
> +	platform_driver_unregister(&platform_driver);
> +
> +fail_platform_driver:
> +	exit_dell_wmi_bios_attr_pass_interface();
> +
> +fail_pass_interface:
> +	exit_dell_wmi_bios_attr_set_interface();
> +
> +fail_set_interface:
> +	return ret;
> +}
> +
> +static void __exit exit_dell_bios_attrib_wmi(void)
> +{
> +	release_attributes_data();
> +	exit_dell_wmi_bios_attr_set_interface();
> +	exit_dell_wmi_bios_attr_pass_interface();
> +	if (platform_device) {
> +		platform_device_unregister(platform_device);
> +		platform_driver_unregister(&platform_driver);
> +	}
> +}
> +
> +module_init(init_dell_bios_attrib_wmi);
> +module_exit(exit_dell_bios_attrib_wmi);
> +
> +MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
> +MODULE_AUTHOR("Prasanth Ksr <prasanth.ksr@dell.com>");
> +MODULE_AUTHOR("Divya Bharathi <divya.bharathi@dell.com>");
> +MODULE_DESCRIPTION("Dell platform setting control interface");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/dell-wmi-sysman-attributes.h b/drivers/platform/x86/dell-wmi-sysman-attributes.h
> new file mode 100644
> index 000000000000..a12c03ab96c9
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman-attributes.h
> @@ -0,0 +1,132 @@
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
> +#include <linux/platform_device.h>
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
> +struct dell_wmi_sysman_priv {
> +	char current_admin_password[MAX_BUFF];
> +	char current_system_password[MAX_BUFF];
> +	struct wmi_device *password_attr_wdev;
> +	struct wmi_device *bios_attr_wdev;
> +	bool pending_changes;
> +};
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
> +int get_##type##_instance_id(struct kobject *kobj)				\
> +{										\
> +	int i;									\
> +	for (i = 0; i <= type##_instances_count; i++) {				\
> +		if (!(strcmp(kobj->name, type##_data[i].attribute_name)))	\
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
> +		return sprintf(buf, "%s\n", type##_data[i].name);		\
> +	return 0;								\
> +}
> +
> +#define attribute_n_property_show(name, type)					\
> +static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr,	\
> +			   char *buf)						\
> +{										\
> +	int i = get_##type##_instance_id(kobj);					\
> +	if (i >= 0)								\
> +		return sprintf(buf, "%d\n", type##_data[i].name);		\
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
> +void strncpy_attr(char *dest, char *src);
> +
> +int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
> +			struct kobject *attr_name_kobj);
> +int alloc_enum_data(void);
> +void exit_enum_attributes(struct kset *kset);
> +
> +int populate_int_data(union acpi_object *integer_obj, int instance_id,
> +			struct kobject *attr_name_kobj);
> +int alloc_int_data(void);
> +void exit_int_attributes(struct kset *kset);
> +
> +int populate_str_data(union acpi_object *str_obj, int instance_id, struct kobject *attr_name_kobj);
> +int alloc_str_data(void);
> +void exit_str_attributes(struct kset *kset);
> +
> +int populate_po_data(union acpi_object *po_obj, int instance_id, struct kobject *attr_name_kobj);
> +int alloc_po_data(void);
> +void exit_po_attributes(struct kset *kset);
> +
> +int set_attribute(const char *a_name, const char *a_value);
> +int set_bios_defaults(u8 defType);
> +
> +void exit_dell_wmi_bios_attr_set_interface(void);
> +int init_dell_wmi_bios_attr_set_interface(void);
> +int map_wmi_error(int error_code);
> +size_t calculate_security_buffer(void);
> +void populate_security_buffer(char *buffer, char *authentication);
> +
> +int set_current_password(const char *password_type, const char *cur);
> +int set_new_password(const char *password_type, const char *new);
> +int init_dell_wmi_bios_attr_pass_interface(void);
> +void exit_dell_wmi_bios_attr_pass_interface(void);
> +
> +#endif
> 

Regards,

Hans

