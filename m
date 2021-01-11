Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FC32F1A77
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388741AbhAKQIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:08:18 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:40525 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbhAKQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:08:17 -0500
Date:   Mon, 11 Jan 2021 16:07:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1610381254;
        bh=ohagdRq1Sd2Cy0v1l5l2Jw2QpLsPD4HQNSkH2PKy5fQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=S7WBQJNY+9r0xZjDUby5bCC4x9NDEI1d0EaDPlk+Z9mxUTdvqhjIjIhdJ0PKggmhm
         kLq4DGIvwjQTeH9x9u/NdrWlZYvpCgfqOLmSQmA739uq7R3On4GlmoeBGjPgkpm8ED
         vr2CSnBTGUslp1wocFiAdyE2f5M6zlf31ay5O+ag=
To:     Perry Yuan <perry979106@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Perry Yuan <Perry.Yuan@dell.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Limonciello Mario <Mario.Limonciello@dell.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell hardware privacy
Message-ID: <EL8a5P1IHqrP-OKgLuz_WhokTdCV5J5wjSDLxpDFgFcvbeK-CuBwZeTTtVXQe-uermqgam418I468i9gNnNykmSuPrCC2M1biKyK44wVfkA=@protonmail.com>
In-Reply-To: <7def1cdc-e275-9ae6-4941-55517359bb1e@gmail.com>
References: <20201228132855.17544-1-Perry_Yuan@Dell.com> <mXtNUreCVsPKizG-fnNKPId9_lQGit0S6pYEpk-aNT1hGQjVwblZDiO4E-YX3hxnrbbNN1-6hSntiv13wz66RxbhXjPJhpAVOIlZmmwUI7w=@protonmail.com> <7def1cdc-e275-9ae6-4941-55517359bb1e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2021. janu=C3=A1r 11., h=C3=A9tf=C5=91 14:42 keltez=C3=A9ssel, Perry Yuan =
=C3=ADrta:

> [...]
> > > +#define PRIVACY_PLATFORM_NAME=09"dell-privacy-acpi"
> > > +#define DELL_PRIVACY_GUID=09"6932965F-1671-4CEB-B988-D3AB0A901919"
> > > +
> > > +struct privacy_acpi_priv {
> > > +=09struct device *dev;
> > > +=09struct platform_device *platform_device;
> > > +=09struct led_classdev cdev;
> > > +};
> > > +static struct privacy_acpi_priv *privacy_acpi;
> >
> > Any reason it needs to be dynamically allocated?
>
> I need to set one static struct to let some function to get the priv poin=
ter.
>
> It is more simple if i add some function and get the priv easily.
>
> If you have better suggestion, i would be glad to optimize it.
>
> for example.
>
> static int dell_privacy_micmute_led_set(struct led_classdev *led_cdev,
>                 enum led_brightness brightness)
> {
>         struct privacy_acpi_priv *priv =3D privacy_acpi;
>
>         ..........................
>
> }
>

My comment was referring to the fact that you could've used
```
static struct privacy_acpi_priv privacy_acpi;
```
to achieve the same result without the dynamic memory allocation.


>
> >
> >
> > > +
> > > +static int dell_privacy_micmute_led_set(struct led_classdev *led_cde=
v,
> > > +=09=09enum led_brightness brightness)
> > > +{
> > > +=09struct privacy_acpi_priv *priv =3D privacy_acpi;
> > > +=09acpi_status status;
> > > +=09acpi_handle handle;
> > > +=09char *acpi_method;
> > > +
> > > +=09handle =3D ec_get_handle();
> > > +=09if (!handle)
> > > +=09=09return -EIO;
> > > +=09if (acpi_has_method(handle, "ECAK"))
> > > +=09=09acpi_method =3D "ECAK";
> > > +=09else
> > > +=09=09return -ENODEV;
> >
> > I find this if-else a bit cumbersome. Any reason why
> >
> > if (!acpi_has_method(handle, "ECAK"))
> >   return ...;
> >
> > would not work? I believe you could also easily do away with the `acpi_=
method`
> > variable.
>
> Just want to make sure the BIOS has the correct  method to call.
>
> normally it will not be failed, just keep it safe to call BIOS, not to ca=
use any panic.
>
> I changed it as below .
>
>         handle =3D ec_get_handle();
>         if (!handle)
>                 return -EIO;
>         acpi_method =3D "ECAK";
>

You could keep the method name in a static variable:
```
static char *acpi_method =3D (char *)"ECAK"; // this is inside the function

handle =3D ...;
if (!handle)
  return ...

if (!acpi_has_method(handle, acpi_method))
  return ...

... acpi_evaluate_object(handle, acpi_method, ...
```

Another thing is that I believe you could do these checks only once,
before registering the LED device.


>
> >
> >
> > > +
> > > +=09status =3D acpi_evaluate_object(handle, acpi_method, NULL, NULL);
> > > +=09if (ACPI_FAILURE(status)) {
> > > +=09=09dev_err(priv->dev, "Error setting privacy EC ack value: %s\n",
> > > +=09=09=09=09acpi_format_exception(status));
> > > +=09=09return -EIO;
> > > +=09}
> > > +=09return 0;
> > > +}
> > > +
> [...]
> > > +static const struct acpi_device_id privacy_acpi_device_ids[] =3D {
> > > +=09{"PNP0C09", 0},
> > > +=09{ },
> > > +};
> > > +MODULE_DEVICE_TABLE(acpi, privacy_acpi_device_ids);
> > > +
> > > +static struct platform_driver dell_privacy_platform_drv =3D {
> > > +=09.driver =3D {
> > > +=09=09.name =3D PRIVACY_PLATFORM_NAME,
> > > +=09=09.acpi_match_table =3D ACPI_PTR(privacy_acpi_device_ids),
> > > +=09},
> > > +=09.remove =3D dell_privacy_acpi_remove,
> > > +};
> >
> > I think using a platform driver here just complicates things for no rea=
son.
> > Furthermore, I'm not sure if there's actually any need for the ACPI mat=
ch table.
>
> there will be some more privacy devices need to add some acpi interface f=
unction here.
>
> including  elctronic privacy screen and privacy camera.
>
> the platform driver can provide more flexible framework to extend.
>

I see. I'm wondering if the ACPI match table is needed at the moment. If I'=
m not
mistaken the platform driver already binds the platform device the module c=
reates.
And there is no real need to bind to the ACPI EC devices.


> [...]
> > > diff --git a/drivers/platform/x86/dell-privacy-wmi.c b/drivers/platfo=
rm/x86/dell-privacy-wmi.c
> > > new file mode 100644
> > > index 000000000000..80637c7f617c
> > > --- /dev/null
> > > +++ b/drivers/platform/x86/dell-privacy-wmi.c
> [...]
> > > +int dell_privacy_valid(void)
> > > +{
> > > +=09int ret;
> > > +
> > > +=09ret =3D wmi_has_guid(DELL_PRIVACY_GUID);
> > > +=09if (!ret)
> > > +=09=09return -ENODEV;
> > > +=09ret =3D privacy_valid;
> > > +=09return ret;
> >
> > I find this function really confusing, and too verbose for what it does=
.
> >
>
> 1. when the DELL_PRIVACY_GUID not found, it will return  ENODEV showing n=
o privacy devices.
>
> 2. when DELL_PRIVACY_GUID found,and wmi privacy driver is registered, it =
will return "0"
>
> 3.when DELL_PRIVACY_GUID found,and wmi privacy driver is NOT registered y=
et, it will return "EPROBE_DEFE"
>
>   the  EPROBE_DEFER is defined in "include/linux/errno.h"
>
> #define EPROBE_DEFER    517     /* Driver requests probe retry */
>
> when caller get this returned , it will defer the caller  1s ~ 7s to prob=
e again.
>
> This will make sure dell-laptop can get the correct privacy status to reg=
ister its micmute led trigger driver or not.
>
> ----dell-laptoo.c-------------------
>
> #if IS_ENABLED(CONFIG_DELL_PRIVACY)
>                 ret =3D dell_privacy_valid();
>                 if (!ret)
>                         privacy_valid =3D true;
> #endif
>                 if (!privacy_valid) {
>                         micmute_led_cdev.brightness =3D ledtrig_audio_get=
(LED_AUDIO_MICMUTE);
>                         ret =3D led_classdev_register(&platform_device->d=
ev, &micmute_led_cdev);
>                         if (ret < 0)
>                                 goto fail_led;
>                 }
>         }
>

My problem is that those three states are never used.
The only thing that's ever checked is if the return value of dell_privacy_v=
alid()
is zero or not. No part of the code distinguishes between -ENODEV and -EPRO=
BE_DEFER.
(As far as I see, I may be missing something.)

My initial point was that - if I'm not missing anything significant - the w=
hole
function could just be:
```
int dell_privacy_valid(void)
{
  return privacy_valid;
}
```
given that you manipulate the value of `privacy_valid` appropriately. And a=
ssuming
the current form is needed, this would be enough:
```
int dell_privacy_valid(void)
{
  if (!wmi_has_guid(...))
    return -ENODEV;

  return privacy_valid;
}
```

But I'd personally prefer the first one.


>
> >
> > > +}
> > > +EXPORT_SYMBOL_GPL(dell_privacy_valid);
> > > +
> > > +void dell_privacy_process_event(int type, int code, int status)
> > > +{
> > > +=09struct privacy_wmi_data *priv;
> > > +=09const struct key_entry *key;
> > > +
> > > +=09mutex_lock(&list_mutex);
> > > +=09priv =3D list_first_entry_or_null(&wmi_list,
> > > +=09=09=09struct privacy_wmi_data,
> > > +=09=09=09list);
> >
> > Can you please explain why this list is needed if only the first entry =
will
> > ever be used?
>
>         mutex_lock(&list_mutex);
>         list_add_tail(&priv->list, &wmi_list);
>         mutex_unlock(&list_mutex);
>
> only one priv struct is added to the list with list mutex protecting.
>
> So it will not have two more entry data added to the list .
>

I'm not sure I fully get it.


>
> >
> >
> > > +=09if (!priv) {
> > > +=09=09pr_err("dell privacy priv is NULL\n");
> > > +=09=09goto error;
> > > +=09}
> > > +=09key =3D sparse_keymap_entry_from_scancode(priv->input_dev, (type =
<< 16)|code);
> > > +=09if (!key) {
> > > +=09=09dev_dbg(&priv->wdev->dev, "Unknown key with type 0x%04x and co=
de 0x%04x pressed\n",
> > > +=09=09=09=09type, code);
> > > +=09=09goto error;
> > > +=09}
> > > +=09switch (code) {
> > > +=09case DELL_PRIVACY_TYPE_AUDIO: /* Mic mute */
> > > +=09=09priv->last_status =3D status;
> > > +=09=09sparse_keymap_report_entry(priv->input_dev, key, 1, true);
> > > +=09=09break;
> > > +=09case DELL_PRIVACY_TYPE_CAMERA: /* Camera mute */
> > > +=09=09priv->last_status =3D status;
> > > +=09=09sparse_keymap_report_entry(priv->input_dev, key, 1, true);
> > > +=09=09break;
> > > +=09default:
> > > +=09=09=09dev_dbg(&priv->wdev->dev, "unknown event type 0x%04x 0x%04x=
",
> > > +=09=09=09=09=09type, code);
> > > +=09}
> >
> > Is this switch needed at all?
>
> It is needed here, camra mute and privacy screen will add more codes here=
.
>
> It want to keep the switch for further extention.
>

My point here is that the two cases of the switch do the exact same thing. =
The
whole switch could be replaced with:
```
sparse_keymap_report_entry(priv->input_dev, key, 1, true);
```

I would go as far as use this:
```
if (!sparse_keymap_report_event(priv->input_dev, (type << 16) | code, 1, tr=
ue))
  dev_dbg(&priv->wdev->dev, "unknown event type=3D0x%04x code=3D0x%04x\n", =
type, code)
```

This would elliminate the need for the `key` variable, the call to
`sparse_keymap_entry_from_scancode()`, and the whole switch.


> [...]
> > There is actually no need for the `pos` variable.
>
> It is used in this keymap codes.
>
>        for (i =3D 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
>                 keymap[pos] =3D dell_wmi_keymap_type_0012[i];
>                 keymap[pos].code |=3D (0x0012 << 16);
>                 pos++;
>         }
>

You can use `i` as the index, so no need for `pos`.


>
> >
> >
> > > +
> > > +=09priv =3D devm_kzalloc(&wdev->dev, sizeof(struct privacy_wmi_data)=
,
> >
> > Please use `sizeof(*priv)`.
>
> fixed.
>
>
> >
> >
> > > +=09=09=09GFP_KERNEL);
> > > +=09if (!priv)
> > > +=09=09return -ENOMEM;
> > > +
> > > +=09dev_set_drvdata(&wdev->dev, priv);
> > > +=09priv->wdev =3D wdev;
> > > +=09/* create evdev passing interface */
> > > +=09priv->input_dev =3D devm_input_allocate_device(&wdev->dev);
> > > +=09if (!priv->input_dev)
> > > +=09=09return -ENOMEM;
> > > +=09/* remap the wmi keymap event to new keymap */
> > > +=09keymap =3D kcalloc(ARRAY_SIZE(dell_wmi_keymap_type_0012) +
> > > +=09=09=091,
> >
> > I don't think that `+ 1` is not needed since the KE_END entry is alread=
y in the array.
> >
> >
> > > +=09=09=09sizeof(struct key_entry), GFP_KERNEL);
> > > +=09if (!keymap) {
> > > +=09=09ret =3D -ENOMEM;
> > > +=09=09goto err_free_dev;
> > > +=09}
> > > +=09/* remap the keymap code with Dell privacy key type 0x12 as prefi=
x
> > > +=09 * KEY_MICMUTE scancode will be reported as 0x120001
> > > +=09 */
> > > +=09for (i =3D 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
> > > +=09=09keymap[pos] =3D dell_wmi_keymap_type_0012[i];
> > > +=09=09keymap[pos].code |=3D (0x0012 << 16);
> > > +=09=09pos++;
> > > +=09}
> > > +=09ret =3D sparse_keymap_setup(priv->input_dev, keymap, NULL);
> > > +=09if (ret)
> > > +=09=09return ret;
> >
> > A copy of the keymap is created by `sparse_keymap_setup()`, so returnin=
g
> > here will leak `keymap`. You could just call `kfree(keymap)` directly a=
fter
> > the `sparse_keymap_setup()` call. But I find it completely unnecessary
> > to do this allocate-copy-modify thing. Is there any reason why the stat=
ic array
> > (`dell_wmi_keymap_type_0012`) cannot already contain the correct values=
?
>
> I don`t quite undestand what you meant
>
> what "correct values" should be contained by the dell_wmi_keymap_type_001=
2?
>

My point is that if you had:
```
static const struct key_entry dell_wmi_keymap_type_0012[] =3D {
=09{ KE_KEY, 0x00120001, { KEY_MICMUTE } },
=09{ KE_SW,  0x00120002, { SW_CAMERA_LENS_COVER } },
=09{ KE_END, 0},
};
```
then there would be no need to create a copy and the code would be simpler.


> [...]
> > > +static int __init init_dell_privacy(void)
> > > +{
> > > +=09int ret;
> > > +
> > > +=09ret =3D wmi_has_guid(DELL_PRIVACY_GUID);
> > > +=09if (!ret)
> > > +=09=09return -ENODEV;
> >
> > The init function of a module that exports symbols must not fail, other=
wise
> > it'll prevent the loading of dependent modules.
>
> Yes, the wmi driver is the entry for whole privacy driver.
>
> if wmi guid query failed, the privacy driver will not be registered.
>
> dell-laptop driver will get "-ENOVDE" from dell_privacy_valid().
>
> it will register its micmute led trigger driver from dell laptop driver.
>

My point is that if dell-privacy is a dependency of dell-laptop, and dell-p=
rivacy
fails to load, then dell-laptop cannot be loaded. Effectively, the lack of
the DELL_PRIVACY_GUID WMI interface will cause the dell-laptop module not b=
e
able to be loaded.


> [...]
> > > +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
> > > +=09=09=09err =3D dell_privacy_valid();
> > > +=09=09=09if (err =3D=3D 0) {
> > > +=09=09=09=09dell_privacy_process_event(buffer_entry[1],
> > > +=09=09=09=09=09=09buffer_entry[3], buffer_entry[4]);
> >
> > What if `len < 5`?
>
> when CONFIG_DELL_PRIVACY is enabled, and dell_privacy_valid return zero w=
hich means privacy driver loaded as expected.
>
> for example ,the micmute report wmi event data len is "5", it will not be=
 less than 5 words.

I'm wondering if there are such guarantees, why is the length checked just =
a
couple lines below?


>
> Process buffer (04 00 12 00 0e 00 01 00 03 00)
>
>
> #if IS_ENABLED(CONFIG_DELL_PRIVACY)

One thing I might have forgotten to point out initially, is that there is n=
o need
for this #if as dell-privacy-wmi.h provides stub definitions for
`dell_privacy_valid()` and `dell_privacy_process_event()`.


>                         err =3D dell_privacy_valid();
>                         if (err =3D=3D 0) {
>                                 dell_privacy_process_event(buffer_entry[1=
],
>                                                 buffer_entry[3], buffer_e=
ntry[4]);
>                         } else {
>                                 if (len > 2)
>                                         dell_wmi_process_key(wdev, buffer=
_entry[1],
>                                                         buffer_entry[2]);
>                                 /* Extended data is currently ignored */
>                         }
> [...]

Another thing I may have forgotten to say: the name `dell_privacy_valid()` =
is
misleading in my opinion, as it gives the impression of being a predicate, =
even
though it is not. `dell_privacy_state()` or something like that would be be=
tter,
I think.


Regards,
Barnab=C3=A1s P=C5=91cze


p.s. please send text emails.
