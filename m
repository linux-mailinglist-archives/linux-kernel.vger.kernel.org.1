Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C56A275DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgIWQs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:48:29 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgIWQs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:48:26 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MoNMu-1knnrE3KES-00oqIB for <linux-kernel@vger.kernel.org>; Wed, 23 Sep
 2020 18:48:25 +0200
Received: by mail-qk1-f169.google.com with SMTP id d20so335291qka.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:48:24 -0700 (PDT)
X-Gm-Message-State: AOAM530kAfZJ3gPupiaM4AwEVn8ygjat2pneOCx6IhdLUbV+PGj91Fwg
        OOpK7HIQzkPwD+ZfbD3fA6avZuf1AWHbVXb73zA=
X-Google-Smtp-Source: ABdhPJxwPE5Wwh+nnLUem9B0IUqYbP4jTGILnxkKfQRyL4o5Z9LHe3qZmwNKQUPSRcKUeo0vvQBam8tKfCiPUd/307w=
X-Received: by 2002:ae9:c30d:: with SMTP id n13mr776598qkg.138.1600879703666;
 Wed, 23 Sep 2020 09:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200923151511.3842150-1-luzmaximilian@gmail.com> <20200923151511.3842150-9-luzmaximilian@gmail.com>
In-Reply-To: <20200923151511.3842150-9-luzmaximilian@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Sep 2020 18:48:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0=98pzgWwBKddy7BQ9g90ga8JEx=MtADW+aqTe0AVV6w@mail.gmail.com>
Message-ID: <CAK8P3a0=98pzgWwBKddy7BQ9g90ga8JEx=MtADW+aqTe0AVV6w@mail.gmail.com>
Subject: Re: [RFC PATCH 8/9] surface_aggregator: Add DebugFS interface
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LzGlxUzl8O4mPqa9WVmdvTU9NYCh/+7hdI/o6b7FVOhhtclLzud
 SdFNT5vaMGwbEM9A6Rd9PhI9VC0yKRefEgs8+KHM5j+aXMnazydYZhNuQljjr3AqCCqLDrW
 3S7KEJjzSamh2j32sM+6jSp3eZfQw9RPuJxADoYkhak0wt7RiX7mIiVuDSKksRbTg1W63aE
 KqifZO9wejqczgaPSqTLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:js0eB8QDwxo=:jt4Aal7awPlrSjIpXr64up
 PkKTc37/RdN6hh08jd/qspoeazLBKvpcpjW07a0gKRXlGdcTQrNcXBe50aTOZkFN2XTwRA3mc
 zFzy+U7jI3SHG3M0WAD6o2FeamMZ4wcdg5CgPyQUqOHoew5zY549BX42L96L6AYXwpV347Ad9
 KgtilV55xfKHAx8elBhz2e5Ss7oa4lKx8AFoYcTmzXexOZtSPzBT44kfmTfVvFT2Vf99FcPoJ
 6DP9fhSE6nMIw3rTBEsZ9PeNSS0b4avRng61Ax1gv8fJe71fKBTdmPu6xMbTNtgs92cZ7kEuA
 2ddBPosPcxneoGVUpRK3qNBDH9rPzki6iypJRxJrV3PF1HcEmk+ocnYqrzMr1L+3uvQvDrP3Z
 mQ9KjoyhcAPyVIrG44LDssDRK4hHwHmeCuWXCjLKFSYmpOOwkBL2qlyF0mfdxU80yCvgSOB5Q
 dc6iwjI566E7fugJzb9ricDceYuk94RflT+h3jbRbnAEaVGLBQ6U5tL0Ff69wnyApJR16lGWU
 l+Ts0Oc64ravNtpzXIlnKa9cRHCXk6oxEyoxeT1x90d0t9bfB6z/aKSjrEBfqWqUhASnD7fD3
 GaWJ6nF8xpjz0g13bG1ZiT0MoxGHsRJpUdwZ8I7BVfXXFAbuYd2bjUtj8/7fPfvr9aUTIUXTq
 Nio/qsJ4aon2z3+Jlcaha41sUHi7gMIhDc9hGgWx5dabqQSF4k3S/4BWqAzAgDX3q8I5mKwai
 8N94WiOETLH2FYVvDkJRH8QvFquF1baBAj3vdqBl6JB6uaP3sHLY7wfcmaCVFQhx0o0VUcsjr
 o3bhKIT4ujgpSZXkCPhBYYK3vyfUOAOLOXV3yCuqPVxFJxFN2wjsWogAR/7GkXyBiPANXTk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>> +   * - ``0xA5``
> +     - ``1``
> +     - ``WR``
> +     - ``REQUEST``
> +     - Perform synchronous SAM request.
> +
> +
> +``GETVERSION``
> +--------------
> +
> +Defined as ``_IOR(0xA5, 0, __u32)``.
> +
> +Gets the current interface version. This should be used to check for changes
> +in the interface and determine if certain functionality is available. While
> +the interface should under normal circumstances kept backward compatible, as
> +this is a debug interface, backwards compatibility is not guaranteed.
> +
> +The version number follows the semantic versioning scheme, roughly meaning
> +that an increment in the highest non-zero version number signals a breaking
> +change. It can be decomposed as follows:

Versioned interfaces are basically always a mess, try to avoid them. I'd much
rather see this done in one of two ways:

a) make it a proper documented interface, in this case probably a misc
character device, and then maintain the interface forever, without
breaking compatibility with existing users.

b) keep it as a debugfs file, but don't even pretend for it
to be a documented interface. Anything using it should know
what they are doing and have a matching user space.

> +/**
> + * struct ssam_debug_request - Controller request IOCTL argument.
> + * @target_category: Target category of the SAM request.
> + * @target_id:       Target ID of the SAM request.
> + * @command_id:      Command ID of the SAM request.
> + * @instance_id:     Instance ID of the SAM request.
> + * @flags:           SAM Request flags.
> + * @status:          Request status (output).
> + * @payload:         Request payload (input data).
> + * @payload.data:    Pointer to request payload data.
> + * @payload.length:  Length of request payload data (in bytes).
> + * @response:        Request response (output data).
> + * @response.data:   Pointer to response buffer.
> + * @response.length: On input: Capacity of response buffer (in bytes).
> + *                   On output: Length of request response (number of bytes
> + *                   in the buffer that are actually used).
> + */
> +struct ssam_dbg_request {
> +       __u8 target_category;
> +       __u8 target_id;
> +       __u8 command_id;
> +       __u8 instance_id;
> +       __u16 flags;
> +       __s16 status;
> +
> +       struct {
> +               const __u8 __user *data;
> +               __u16 length;
> +               __u8 __pad[6];
> +       } payload;
> +
> +       struct {
> +               __u8 __user *data;
> +               __u16 length;
> +               __u8 __pad[6];
> +       } response;
> +};

Binary interfaces are hard. In this case the indirect pointers mean that
32-bit user space has an incompatible layout, which you should not do.

Also, having an ioctl on a debugfs file is a bit odd. I wonder if you
could have this as a transactional file that performs only read/write
commands, i.e. you pass in a

struct ssam_dbg_request {
       __u8 target_category;
       __u8 target_id;
       __u8 command_id;
       __u8 instance_id;
       __u16 flags;
      __u8 payload[]; /* variable-length */
};

and you get out a

struct ssam_dbg_response {
      __s16 status;
     __u8 payload[];
};

and keep the rest unchanged. See fs/libfs.c for how this could be done
with simple_transaction files.

      Arnd
