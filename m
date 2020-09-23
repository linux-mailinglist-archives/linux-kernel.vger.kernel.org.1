Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ECD276080
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 20:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgIWSvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 14:51:32 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39379 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgIWSvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:51:32 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MoOty-1kncyn30Js-00okW4 for <linux-kernel@vger.kernel.org>; Wed, 23 Sep
 2020 20:51:29 +0200
Received: by mail-qk1-f171.google.com with SMTP id w16so755920qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 11:51:29 -0700 (PDT)
X-Gm-Message-State: AOAM530wTRTbe7aSZifQzLpoJS4x/bHvih3Z50Ok33ch7w6waBdT1rGu
        xl8jvIaEn53IDDNhkRIvXVcC+U92UzIC7U05P30=
X-Google-Smtp-Source: ABdhPJyl1jWEhi/uyTDbftGON5pd8Rbbh0mMXV5U8u1tBsoBDcfGpPXKp5W/rwPqRWmX0FqoL81e9t05fZvJNbZu/f4=
X-Received: by 2002:ae9:c30d:: with SMTP id n13mr1302520qkg.138.1600887088560;
 Wed, 23 Sep 2020 11:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-9-luzmaximilian@gmail.com> <CAK8P3a0=98pzgWwBKddy7BQ9g90ga8JEx=MtADW+aqTe0AVV6w@mail.gmail.com>
 <cfed1f74-653c-565b-ea91-877c4e1f63a0@gmail.com>
In-Reply-To: <cfed1f74-653c-565b-ea91-877c4e1f63a0@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Sep 2020 20:51:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0_i=wHnQmfbjCdMgFRSD0eGjEM2uMFft5FJ4M1GSUbHg@mail.gmail.com>
Message-ID: <CAK8P3a0_i=wHnQmfbjCdMgFRSD0eGjEM2uMFft5FJ4M1GSUbHg@mail.gmail.com>
Subject: Re: [RFC PATCH 8/9] surface_aggregator: Add DebugFS interface
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gwJTXScFeifUbAbXEoVn1RuK9heyBYiWAXMyMfnYQfV0RvKb4i+
 wf95639T2CfGnCJtQTA1Xl7IyDm7vtLOagPDusN8Jdi43XguCKcjj3uD3+c66vCndXeUJek
 KibPzSB94w/ud+IpFVJldl5WaQVyz+NGad2VaworAcCklhlBrEptEGuXIlMaXzjGDa0cugt
 5k1smzo8vKcMNPs1vl6VA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:87oAlFH42VU=:qvW20sVTxjet7Azrc4uhrp
 GVGMD+aS/Kng7z19H1nknoqaXBsPtBNgGIt49D+s2sEWIRUSpozgAT+XDEI00Xuy//jhjUUgG
 gYzqtxzZNvCl7gjXb9n6GLwo8h5A2gSuJqQNYlRO1tHtL0KIcokEuEbtGwoY1XDFiHdsxpkT4
 htSRBJVpR7zezg76JvuFVI/cO5RkZp+r6VyHGnQh1ebYrEfTL+ShrYj7YdXPsNe+aQDnceaS5
 jegMvw2J70LVKU5eChWUZSBoLWEdEbS6ir+mg0jIUivi/fdHDpx/9mDyHVdycJEImb62GeoXH
 JHaZyJPHZHZ4y0w+3YwMzissrVH2AWuHT8pBl6MPqbQrLH0Zk2HPm7JrB3Yup9plRQTlbXxxR
 +3AVJOU7l0f497FUWSKBbLp3e6/vejyIJnj9Hsd1dmBSOFkDXyIEg/ZCMLTgbKSgIPBVCSvv/
 LTEzg/8ALp9QNhezyuVG3Dd0Uwt8qKvEVsFikFUNY1uJZ/KhcaGmAnuJMpQw2tJ3c/m0gvScq
 T+fpB56dSA95hyhXV9h2JvJMe1vMpfepGnRQ7jRpbHN3SiLK79TxNLvBvw9Wn+6tvWTkoLs3v
 G/Ng6lJTZYpynffH4r8Lix1tZ5AGWdjugti+06HivLE2D6uPGeYATrmCaEClgDvFhm20LCQmG
 cGaJbbpQvuOZwDO89vXuagNPw+mYUmcvlwjrKzkgAUfZLNZc8rUpO0slqQGwPhLmOwN7+RCCY
 okKvUW7OmREcPOx2uFwQZ5OZN/0zHy+EmV8AxGiekb4dIOjsRWPWltmJhTEbEfGcZvRThf+h/
 7jEOpcNkfuKb6zoWxx0qHyn4NeF6S4F/mq67nZpCZX6zxN/UONg/q1i2Vet0c8RNP7jOGOygn
 TVbssxb0oIhUdggeEpSBrIM4RqR+11GlJmDu1wTOOs4awoPVlapflowH0ijDKv+HbGbOk0oTx
 lubdxS/63Ylt/4g1SV4W3OC3W9QLw7UDiugHf59lwW54pUlypFpQH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 8:29 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> On 9/23/20 6:48 PM, Arnd Bergmann wrote:
> >> + * struct ssam_debug_request - Controller request IOCTL argument.
> >> + * @target_category: Target category of the SAM request.
> >> + * @target_id:       Target ID of the SAM request.
> >> + * @command_id:      Command ID of the SAM request.
> >> + * @instance_id:     Instance ID of the SAM request.
> >> + * @flags:           SAM Request flags.
> >> + * @status:          Request status (output).
> >> + * @payload:         Request payload (input data).
> >> + * @payload.data:    Pointer to request payload data.
> >> + * @payload.length:  Length of request payload data (in bytes).
> >> + * @response:        Request response (output data).
> >> + * @response.data:   Pointer to response buffer.
> >> + * @response.length: On input: Capacity of response buffer (in bytes).
> >> + *                   On output: Length of request response (number of bytes
> >> + *                   in the buffer that are actually used).
> >> + */
> >> +struct ssam_dbg_request {
> >> +       __u8 target_category;
> >> +       __u8 target_id;
> >> +       __u8 command_id;
> >> +       __u8 instance_id;
> >> +       __u16 flags;
> >> +       __s16 status;
> >> +
> >> +       struct {
> >> +               const __u8 __user *data;
> >> +               __u16 length;
> >> +               __u8 __pad[6];
> >> +       } payload;
> >> +
> >> +       struct {
> >> +               __u8 __user *data;
> >> +               __u16 length;
> >> +               __u8 __pad[6];
> >> +       } response;
> >> +};
> >
> > Binary interfaces are hard. In this case the indirect pointers mean that
> > 32-bit user space has an incompatible layout, which you should not do.
> >
> > Also, having an ioctl on a debugfs file is a bit odd. I wonder if you
> > could have this as a transactional file that performs only read/write
> > commands, i.e. you pass in a
> >
> > struct ssam_dbg_request {
> >         __u8 target_category;
> >         __u8 target_id;
> >         __u8 command_id;
> >         __u8 instance_id;
> >         __u16 flags;
> >        __u8 payload[]; /* variable-length */
> > };
> >
> > and you get out a
> >
> > struct ssam_dbg_response {
> >        __s16 status;
> >       __u8 payload[];
> > };
> >
> > and keep the rest unchanged. See fs/libfs.c for how this could be done
> > with simple_transaction files.
>
> Thanks! Is there a way to make this compatible with a 32-bit user space?

The version I showed avoids the pointers and is compatible with
32-bit user space.

>  From a quick search, compat_ptr and compat_uptr_t would be the right way
> to transfer pointer?

If you end up needing an indirect pointer, the most portable way is to
use a __u64 and read it using u64_to_user_ptr() in the kernel.

> I've already laid out my main two rationales for using an IOCTL in the
> reply to Greg, but here's an overview: First, IOCTLs allow me to execute
> requests in parallel with only a single open file descriptor, and
> without having to care about allocating buffers for the responses and
> waiting until the buffer is read (yes, arguably I still have to manage
> buffers, but only in the IOCTL function which I consider a bit more
> manageable). I was previously unaware of the simple_transaction helpers
> though, so thanks for that pointer! Second, I can easily expand that
> interface to handle events sent by the EC, by having the user space
> application read from that file. Although that could be moved to a
> second file. I just felt having that option of keeping in one would
> eventually result in a cleaner interface

The debugfs way is usually to just have additional files when you
do more than one thing, or if you need a new variant of that interface,
they are cheap.

      Arnd
