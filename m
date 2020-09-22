Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC3273C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgIVHld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:41:33 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33989 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgIVHld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:41:33 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MEVFi-1kEY770C0A-00FxzM; Tue, 22 Sep 2020 09:41:31 +0200
Received: by mail-qk1-f169.google.com with SMTP id d20so18163177qka.5;
        Tue, 22 Sep 2020 00:41:30 -0700 (PDT)
X-Gm-Message-State: AOAM530EfDl0mq76ecxKNVmlWDH+nLLJ5NYYKtnTxig3UJesG/GFuVrC
        j+o+YsnLQhf4VbgYBWPPR0rpYgjF76LEEbGtVgI=
X-Google-Smtp-Source: ABdhPJyM1tNepTGALsdlHBv1Fa4ejpqxEEgdFOkA02UZmfdvHSDO3faSvK+QsRae1sJuOzwbaRgOudnQ3ZjIVeOH5XE=
X-Received: by 2002:a05:620a:15a7:: with SMTP id f7mr3368890qkk.3.1600760489821;
 Tue, 22 Sep 2020 00:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200922023151.387447-1-warthog618@gmail.com> <20200922023151.387447-5-warthog618@gmail.com>
In-Reply-To: <20200922023151.387447-5-warthog618@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Sep 2020 09:41:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1o4fp=-gU=SpwR540Xw+oySJ_ESkG+YXZJsDV-N6UF5w@mail.gmail.com>
Message-ID: <CAK8P3a1o4fp=-gU=SpwR540Xw+oySJ_ESkG+YXZJsDV-N6UF5w@mail.gmail.com>
Subject: Re: [PATCH v9 04/20] gpio: uapi: define uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MgJul94/STlqBONRR9G7hUEh7dJFOZ9YRjtbMyIgDeedXYjKSWf
 nbl2rD9b4VeYHalvWj+DjTcbjTwqnNtgCGtPcbhbzgYhKQfkPl3wcGSuLWr/3TFCjFHh3Hb
 ao/qOsbQvOEx2TKR+tzW40qHslRiL/kK75vP6bAUaGZmw97CU/2Mohm6MTFxkRCzDjPSt3v
 lBoaxYHaQbczC+h9F6R+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eWmhPfKqk8c=:IP0PGelGYrFnOg56Z1gXwh
 8f5vuMn3qLK4FRpyj3A34YNunWVqTTn3b8/vfdteV9+FBCKyzyx5WEtq6Lj365XTj6V0Oo6Tl
 Z1honnEDhDjV8DOwf7NvQECZbiMqgMdtmSUTJphT+NdM3h81AcoNNtKebknbcn6jqGdDbQS2X
 b1Rc1JbO78OCZkjlofF1FYEI/lVGRBPwGPax7vr0dUeWsXf/ffYvwqdv4kudusdNJUhdFzZqo
 NrkuRtMSwTuv6YrJV7ltc7fn/t9aSZ0AN1gSd3hLMYVCI7wheklWfW/hCZOrNpLLFc9jcabnl
 5Xb5qdwAY/ThQDIJwwo3fI65yoPFxx1UmvGFmOVWJioNRmlqW2fUUttC2Hd2uba8O0l4Hzh7y
 hEAjJsSJsMi5jndCZuqCUWa4gcb+4uLzSp2mDt7Tntqri/X1ordr433wL85/kjvVJytn16DeM
 Lj0Ag5WRTLfdOrsCoIoo2PZDETFl2ovwJQCyoSBae+wVYawt8toOoPkaWgt2kmx5d5Ob4Nbdw
 Sh7focFwlG4V6IzjgJjG0eRc6jrWZJdqZl093XQSU6VZ6fB0C2ik5cgacMhYT18vGkDOTZhR/
 O2Df8bxJcaI5RDEFHN+Eix+F5OrXdhbQacgzapE+qEdJvWO9cPyDmuVkEaoskvBzCZN186Rpd
 VNaUBRYWYpAzaa99DE4skHfTe0MeQh65QuQ47fGXK0wtrUOt0Cg8w/9EY6GrGQ7krG9MtLCSh
 DoQulKdrN6iTumNjrgVArcSVgNZv0yi+aTqXC6uEGVCtQEGx1bdiOBtoUNh/tab814BjE3pVh
 a2V7oXFSC4msa9hZ/x/As4WzN+k3AUCDy8WSFpoKl28vpcz0OSbczw1DJETUtbFStoDd09FRx
 pkMaxQwcs0K2SnbSJI581IxYEx4wxLKggJ0UGqsAZTcc56ydE6iM/z1xj3q/Zk7uljCzAhyQK
 n/jtBq0NA8RGHqto/JS392yO+0s5BXJupi6mbaIPeCTd4yHn/xc9d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 4:34 AM Kent Gibson <warthog618@gmail.com> wrote:
> +/**
> + * struct gpio_v2_line_attribute - a configurable attribute of a line
> + * @id: attribute identifier with value from &enum gpio_v2_line_attr_id
> + * @padding: reserved for future use and must be zero filled
> + * @flags: if id is GPIO_V2_LINE_ATTR_ID_FLAGS, the flags for the GPIO
> + * line, with values from enum gpio_v2_line_flag, such as
> + * GPIO_V2_LINE_FLAG_ACTIVE_LOW, GPIO_V2_LINE_FLAG_OUTPUT etc, OR:ed
> + * together.  This overrides the default flags contained in the &struct
> + * gpio_v2_line_config for the associated line.
> + * @values: if id is GPIO_V2_LINE_ATTR_ID_OUTPUT_VALUES, a bitmap
> + * containing the values to which the lines will be set, with each bit
> + * number corresponding to the index into &struct
> + * gpio_v2_line_request.offsets.
> + * @debounce_period_us: if id is GPIO_V2_LINE_ATTR_ID_DEBOUNCE, the desired
> + * debounce period, in microseconds
> + */
> +struct gpio_v2_line_attribute {
> +       __u32 id;
> +       __u32 padding;
> +       union {
> +               __aligned_u64 flags;
> +               __aligned_u64 values;
> +               __u32 debounce_period_us;
> +       };
> +};

Having different-sized members in the union makes it hard for
something like strace to print the contents. How about just making
them all __aligned_u64 even when 32 bits are sufficient?

> +struct gpio_v2_line_request {
> +       __u32 offsets[GPIO_V2_LINES_MAX];
> +       char consumer[GPIO_MAX_NAME_SIZE];
> +       struct gpio_v2_line_config config;
> +       __u32 num_lines;
> +       __u32 event_buffer_size;
> +       /* Pad to fill implicit padding and reserve space for future use. */
> +       __u32 padding[5];
> +       __s32 fd;
> +};

> +struct gpio_v2_line_info {
> +       char name[GPIO_MAX_NAME_SIZE];
> +       char consumer[GPIO_MAX_NAME_SIZE];
> +       __u32 offset;
> +       __u32 num_attrs;
> +       __aligned_u64 flags;
> +       struct gpio_v2_line_attribute attrs[GPIO_V2_LINE_NUM_ATTRS_MAX];
> +       /* Space reserved for future use. */
> +       __u32 padding[4];
> +};

These are both several hundred bytes long, requiring a lot of data
to be copied to the stack and take up space there. I see this is not
actually much different for the v1 API, but I wonder if there has been
any analysis of whether this has a noticeable effect on application
runtime.

         Arnd
