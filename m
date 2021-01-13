Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553A72F579B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbhANCCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbhAMXj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:39:56 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBAEC061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:47:30 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 19so4522217qkm.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+FqGCykPSHqWh7cxX3d9VdlwZG4V5G5JNIRu5wpRt4=;
        b=H5Bfii1PDUDNIlTTwSyW6VN6E9N6jcYRGggL87RbPSRzyVEYxXkdHeiHFD+kvaD5VV
         scGoJezQQf+X8lcwnd6LgdraIehHTUaLmNQY54rwXtX0EBUohI8PyGfaZohjvuKHZAQ6
         amuET9y/crD5ChPV6NPUQGO7+568VT1/N44Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+FqGCykPSHqWh7cxX3d9VdlwZG4V5G5JNIRu5wpRt4=;
        b=r7jg59lB/xerfxNgYq6hXUxrHveuS7tT0/Zyf6Nb6Pqb9lu+9aPfs0Ke+Jq1MaJMsG
         mg4eHRBD5tIRX0J406NIkU5hpgaWXa8Nvmhs7QAX4mbe9VPpjndkCsATysAH4/11Zz8+
         4s1orYnp0zjHh1ow40sC4VljKyTgsfyp6AkFUx2ImY1rpH0nxJefycULSBUNFW4CtN6U
         BsRlxka+4bRV31I02TJVrDcpaqfIEyN5NecumqzUUUg3OwCSey3shaetvP8zEhCBlMIr
         YqfEMsJcY/b2hFHEKuHLgpnUVhXTioPRwcpVvUN9FAKNprs8tWPCxIOcSDeMBSX1dzAD
         jG0g==
X-Gm-Message-State: AOAM531Xp1D+AIXi3ryOlrJ9+VUwyUbT4q4jr0uoRr1iPSvAg0gGdX3m
        wATzTboOGYUrZNHJrXcdGS6ku+NjEVQggookw0zpew==
X-Google-Smtp-Source: ABdhPJw8exMIp6KEAqr10pn2/JqKH9Qo/CkxRzriiBrjuWmyCeaq02m2Sib01Zj3AFuNb2EGWweFcJ9Xm97g3nvBBb0=
X-Received: by 2002:a5b:54a:: with SMTP id r10mr6762311ybp.250.1610578049597;
 Wed, 13 Jan 2021 14:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20210107154200.v4.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
 <20210107154200.v4.2.Ibe7d7d53c5b4fe72c60de90111ff763b53f38dbb@changeid>
 <161041827643.3661239.17919996906733477213@swboyd.mtv.corp.google.com>
 <CA+cxXhm45emyg-9j99U=UWY8QuhzWifh+VvsFBaTOTWs81tvUQ@mail.gmail.com> <161052058590.3661239.5654596152411573148@swboyd.mtv.corp.google.com>
In-Reply-To: <161052058590.3661239.5654596152411573148@swboyd.mtv.corp.google.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Wed, 13 Jan 2021 14:47:18 -0800
Message-ID: <CA+cxXhmZd0eeLjUwcTevZRNovbZWXNKQH5qOX_YFCKowxHNVfQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Input: cros-ec-keyb - Expose function row physical
 map to userspace
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:49 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-01-12 15:55:28)
> > On Mon, Jan 11, 2021 at 6:24 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Philip Chen (2021-01-07 15:42:09)
> > > > The top-row keys in a keyboard usually have dual functionalities.
> > > > E.g. A function key "F1" is also an action key "Browser back".
> > > >
> > > > Therefore, when an application receives an action key code from
> > > > a top-row key press, the application needs to know how to correlate
> > > > the action key code with the function key code and do the conversion
> > > > whenever necessary.
> > > >
> > > > Since the userpace already knows the key scanlines (row/column)
> > > > associated with a received key code. Essentially, the userspace only
> > > > needs a mapping between the key row/column and the matching physical
> > > > location in the top row.
> > > >
> > > > This patch enhances the cros-ec-keyb driver to create such a mapping
> > > > and expose it to userspace in the form of a function-row-physmap
> > > > attribute. The attribute would be a space separated ordered list of
> > > > row/column codes, for the keys in the function row, in a left-to-right
> > > > order.
> > > >
> > > > The attribute will only be present when the device has a custom design
> > > > for the top-row keys.
> > >
> > > Is it documented in Documentation/ABI/?
> > Not yet.
> > Is it proper to add the documentation to `testing/sysfs-driver-input-keyboard`?
>
> Somewhere in testing is fine. I'm not sure if it is a generic proprty
> for all keyboards though? What's the path in sysfs?
I wouldn't say it's generic.
It is available in the keyboard device node only when the board has a
custom top-row keyboard design.
The path in sysfs is something like:
/sys/class/input/input0/device/function_row_physmap, where input0 is
cros_ec.
>
> > >
> > > >
> > > >  /**
> > > >   * struct cros_ec_keyb - Structure representing EC keyboard device
> > > >   *
> > > > @@ -42,6 +44,9 @@
> > > >   * @idev: The input device for the matrix keys.
> > > >   * @bs_idev: The input device for non-matrix buttons and switches (or NULL).
> > > >   * @notifier: interrupt event notifier for transport devices
> > > > + * @function_row_physmap: An array of the encoded rows/columns for the top
> > > > + *                        row function keys, in an order from left to right
> > > > + * @num_function_row_keys: The number of top row keys in a custom keyboard
> > > >   */
> > > >  struct cros_ec_keyb {
> > > >         unsigned int rows;
> > > > @@ -58,6 +63,9 @@ struct cros_ec_keyb {
> > > >         struct input_dev *idev;
> > > >         struct input_dev *bs_idev;
> > > >         struct notifier_block notifier;
> > > > +
> > > > +       u16 function_row_physmap[MAX_NUM_TOP_ROW_KEYS];
> > > > +       u8 num_function_row_keys;
> > >
> > > Why not size_t?
> > I usually try to use the minimal required bytes for variables, even
> > for local ones.
> > In this case, we only need one byte for num_function_row_keys.
> > Are there any reasons why size_t is better?
>
> I suppose to indicate that it's an array size. It's not a super strong
> argument but the usage of u8 looks like we're trying to save space in a
> single structure instance (or maybe a couple if there are a few
> keyboards), when for all I know it actually generates worse code because
> it has to do some masking operation on the load from memory when it
> could just load the value directly into a register.
OK, I'll do size_t.
>
> > >
> > > >  };
> > > >
> > > >  /**
> > > > @@ -587,6 +613,52 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static ssize_t function_row_physmap_show(struct device *dev,
> > > > +                                        struct device_attribute *attr,
> > > > +                                        char *buf)
> > > > +{
> > > > +       ssize_t size = 0;
> > > > +       u8 i;
> > >
> > > int i? Why u8? Surely the size of a local variable isn't important.
> > The same reason as "u8 num_function_row_keys".
> > Is int better in this case?
>
> Yeah int is better because it's a local variable and nobody cares about
> those extra few bytes.
OK, I'll do int.
>
> > >
> > > > +       struct cros_ec_keyb *ckdev = dev_get_drvdata(dev);
> > > > +
> > > > +       if (!ckdev->num_function_row_keys)
> > > > +               return 0;
> > > > +
> > > > +       for (i = 0; i < ckdev->num_function_row_keys; i++)
> > > > +               size += scnprintf(buf + size, PAGE_SIZE - size, "%02X ",
> > > > +                                 ckdev->function_row_physmap[i]);
> > > > +       size += scnprintf(buf + size, PAGE_SIZE - size, "\n");
> > > > +
> > > > +       return size;
> > >
> > > I'd rather see
> > >
> > >         ssize_t size = 0;
> > >         int i;
> > >         struct cros_ec_keyb *ckdev = dev_get_drvdata(dev);
> > >         u16 *physmap = ckdev->function_row_physmap;
> > >
> > >         for (i = 0; i < ckdev->num_function_row_keys; i++)
> > >                 size += scnprintf(buf + size, PAGE_SIZE - size,
> > >                                   "%s%02X", size ? " " : "", physmap[i]);
> > >
> > >         if (size)
> > >                 size += scnprintf(buf + size, PAGE_SIZE - size, "\n");
> > >
> > >         return size;
> > >
> > > And I wonder if hex_dump_to_buffer() works for this?
> > It seems to work? I'll give it a try.
> > If hex_dump_to_buffer() doesn't work, I'll fall back to the
> > implementation you suggested above.
>
> Ok sounds good.
