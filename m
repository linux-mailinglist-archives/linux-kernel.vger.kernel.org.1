Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39EC2AA767
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 19:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgKGSX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 13:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgKGSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 13:23:26 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD09C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 10:23:25 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id p10so4558111ile.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 10:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SWvAMfQA9z80rJcmwxhbT5hZPzfnDNXqqlkFXiR3xHU=;
        b=Au+Ja2W4IhASnVUcH1cy9ImZNM+Lfknj10nCDmrck4VPZTJolUWWmmxFanGTgfinBV
         bO9oB+3MGDsQaBqWL4fuHGVqW4tzeAriF0cQr8JLQdn2Au7RjtaiunjzwVcB+wv7DU5d
         jUM/EDAw1vAAyx1llRCRLbKVE6sDm2uxSJMZ+0BV1MsyWOrhmH2PJyDSctm85l8tUIlG
         5yG+z+ynTxXtWlPwNk5FBGlL6VujEg694q4laUnnetBl666JnUR0U0lwejT+FOkVK0Dq
         t5bChZV4TN1dQA+CdyzS9sBL6kHVzBV+uhIlvliYqz7+oC/AwL1yQpM0tEBtSKcqrntC
         2uLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SWvAMfQA9z80rJcmwxhbT5hZPzfnDNXqqlkFXiR3xHU=;
        b=VfTGJqZ9HrnevLVoY8IPxjudxZxeCRUU4Wpn9nRahwaXIlyx4ekcQj4nkohlnjuR15
         zLxWR5Zqy5dwKHtvTfoFo/Erkj+Wembri845tQGyUll6NNKGuq6wc6ugscfZ83OpDqk1
         a3uNpcEwc/bygQQl/TCfaFTbYNSX7w9Z6GjSKqO0/QqfNeRI9/2WttX7K0cWAn8K0Ctk
         OfMQgfk57bCBFhMdak/QgeJQHkgsa/gS2d10Od17YINLPLydyzFFIJPZFubvlgR2dqcz
         aGM7LTSd1rqVb/4WbACsXXhayuaCd3viLh3LBzwHs6zyRMyNRyNVjN9mJ0WqCzHSLayQ
         UaBQ==
X-Gm-Message-State: AOAM533K4k959VqGOe4sMcFynt4VKSrlzgYn7IbO28tFJSv3hn193P4t
        zgz/r7KrHETjzeg3WQphDnoNACY+LklIFbJR+nIJ9Ufmen6Rpw==
X-Google-Smtp-Source: ABdhPJyB/rFkDR1DtMUNLIhGLu5wR4XtuimBKi7PKuE6WrZ6YozG9eFLdoQyzgOq2oLhxsRb8W0D/MgXp/hvLyM83VE=
X-Received: by 2002:a05:6e02:f0e:: with SMTP id x14mr4860624ilj.307.1604773403702;
 Sat, 07 Nov 2020 10:23:23 -0800 (PST)
MIME-Version: 1.0
From:   Christopher Piggott <cpiggott@gmail.com>
Date:   Sat, 7 Nov 2020 13:23:10 -0500
Message-ID: <CANgRfom0=qz8Dh66y-ukTALgg_-q+RSpgHqfmz9u4Ou8U30JBQ@mail.gmail.com>
Subject: HID device development question: getting hid-generic out of the way
 for a custom egalax touchscreen driver
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a touchscreen device that uses an egalax controller.  When it
starts up, it gets grabbed by hid-generic.  The basics work, but for
some reason a few manufacturers put the touch controller 90 degrees
out of whack with the actual display, so you have to do an affine
transform to rotate it either CW or CCW 90 degrees like this:

     abs_y = x
     abs_x = YMAX - y

The way I normally would fix this is all within xorg, but what I'm
doing right now is for android and I want to fix it up entirely in the
driver.  The trouble is, hid-generic grabs the device, and there's not
really a place in there (at least not that I can see) where I would
want to do this.

What I would like to do is make a replacement driver that can,
optionally, give you a place to poke in a transformation matrix -
perhaps into /sys somewhere, I think I know how to do this:

- I added an option to Kconfig called (for now) HID_EGALAX_CHRISP
- Modified drivers/hid/Makefile to add obj-${CONFIG_HID_EGALAX_CHRISP}
       += hid-egalax-chrisp.o
- Modified drivers/hid/hid-quirks.c such that this particular VID:PID
combination does not include HID_QUIRK_MULTI_INPUT
- Make a .config that turns that driver on

My template is basically the ALPS touch driver.  My driver is
basically empty right now.  It declares its interest in this specific
device:


   static const struct hid_device_id hid_device_table[] = {  {
HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, 0xeeef, 0x0001) }, { } };
   MODULE_DEVICE_TABLE(hid, hid_table);

and it declares a HID callback table that looks like this:

    static struct hid_driver hid_egalax_driver = {
            .name = "hid-egalax-chrisp",
            .id_table = hid_device_table,
            .input_mapping = egalax_input_mapping,
            .input_configured       = egalax_input_configured,
            .raw_event = egalax_raw_event,
            .probe = egalax_probe,
    };
    module_hid_driver(hid_egalax_driver);

All those functions just do printks so I can try to figure out what
it's doing then build up a real driver from there.

The problem I have is that even with all these declarations
hid-generic still grabs control of the device and none of my own
functions ever get called.

I have two questions here:

- What exactly is the procedure by which you tell the HID subsystem
"Don't use generic, I have a specific driver for this?"
- Is this an overall bad approach, i.e. should I be, for example,
adding a ROTATED quirk or something like this?  (Not all eGalaxy
devices will be rotated, though).

--Chris
