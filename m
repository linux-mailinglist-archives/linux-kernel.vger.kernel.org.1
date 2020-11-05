Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C8A2A7C48
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgKEKwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730108AbgKEKwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:52:42 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAAFC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 02:52:42 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id p15so1076214ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 02:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbC7h6sutytvBKVgRkW8YBm4v4oQThhwvuIz3XlFJpw=;
        b=d/RC4QlHsEU0Pk+87b5hebgQR1nvUbGfz+KWgyYPw8avJty+oHtYWwRBfI9ZwNnjQk
         6x1f9VNEkjxS+WacQizm9QFnRFRoNTRgXz7J8hUL7gDHTr1r0B4CDTIH++hxOUWPbRHA
         faB9Z1G3wfURCCb570cPMFzwdpYsz5NNLR9grwb6NletLAXur80zPGuj6TnPTgqIsI6W
         73tvdQLbSeHs/ZIHScGvMbbglljfvtEcmDpRr1SmCjt0Cs2115AxcxEJIltrAcsJpAIs
         i7f4CKXDgFTYIlx2Oia+shgKsQ9vbBqcm5RZnKYsE+6tO+5eUkPHBV9yZoGBsu8zWwxP
         sFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbC7h6sutytvBKVgRkW8YBm4v4oQThhwvuIz3XlFJpw=;
        b=d/9JIgpKP7vq2zYYGaiP2z4hw8Tlslnf0S4n5QBbfm3scejzPTrLEt02mQ4itC4J4G
         TI+v4Dw5BO8giJtdE9ytvs8dTeiVD65F0s9F2W2HzT1gJYSvS1PkUchO3DC0QpjXh5du
         XcbQ+LvjFsYSe5vu/WyRUOBG9eSMQCl8xHCjM9e3uQ/jv4pCusPBTCQZPcd9zSVSNikF
         9AG0lT3bXF6tnQFc49nlWCHumoDRHnPPHKKmTQxifFVQdF55e+jZmmCcWP4vz5ebDvvR
         tq9k2O+XOgdTkLx/z+RwwKM5u0VfTlJ4zAWoLfNj5HRIjNmnxhSenO76t+MR+TXsxbCO
         RaJg==
X-Gm-Message-State: AOAM532ZpV2h//a3OFAQawlYnz1Esyx/rx/vLU06kaN7bCKn/cIyZUiN
        Ow7ucDGoy+rfYsMrKed1cBmKjAX+AVYnPolSXa378A==
X-Google-Smtp-Source: ABdhPJwMZsQSFYx3yHXvvtRlVkabm7C64j8LuP2+XUU2+XVFwAx/DWoa4YDvNPprZ43yAgspd5XcguY3mqI1O9Ir5Vs=
X-Received: by 2002:a05:651c:1205:: with SMTP id i5mr726163lja.283.1604573560846;
 Thu, 05 Nov 2020 02:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20201027121725.24660-1-brgl@bgdev.pl>
In-Reply-To: <20201027121725.24660-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 11:52:30 +0100
Message-ID: <CACRpkdYbpOZGmWONeOQFY7DE+t2ev30DQQ-8cxrJNoK9fVVunA@mail.gmail.com>
Subject: Re: [PATCH 0/8] slab: provide and use krealloc_array()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev <netdev@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 1:17 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Andy brought to my attention the fact that users allocating an array of
> equally sized elements should check if the size multiplication doesn't
> overflow. This is why we have helpers like kmalloc_array().
>
> However we don't have krealloc_array() equivalent and there are many
> users who do their own multiplication when calling krealloc() for arrays.
>
> This series provides krealloc_array() and uses it in a couple places.
>
> A separate series will follow adding devm_krealloc_array() which is
> needed in the xilinx adc driver.

The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I really like this.

Yours,
Linus Walleij
