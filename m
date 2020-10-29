Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C8F29DBB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbgJ2ANL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390748AbgJ2ANK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:13:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721F6C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:13:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k25so1163380lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjZ0C47sBFE4E/dMNMwf9DAUHIodX8mtYvgDRoLI4EA=;
        b=YRSR+UuG72ciMnSbkIKW71fwluhc008uXS+zCtS9AHDFnFwQEIMMgP/YxKO2Dy1307
         WP7/iso+nlAS+anmA1lgk8lE/LiU6ECV1Z6zNFlM6NINwI35F0XF+CWuJQeINp59prgV
         jihocwVqHZpzzVYcqIAvrcvpd/gtQFCguDskE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjZ0C47sBFE4E/dMNMwf9DAUHIodX8mtYvgDRoLI4EA=;
        b=BBKXg7DpNbaEbd/PwaNg3DVuO0Kne/9s2GtXe16Yu4lwL7Ek2zYwmiCtdJKJR76U5q
         co+DgG3F+/pRS4m8ZkVZI7C/Z5s5OpDu1YywPd6sgOGxfZAlq9jsuaFc9N/ar9Larj+O
         dCS517Zsz2gMzTWLq4VrsHihRepb06VmV4ggg61x6JtjKoXec1dEFCE6Vk3ZYFCt9LYC
         Leklv3HmERC/J3UJ3pJA/aZYYqw+zKg/yGb9Phax+yKadWnlzerQ8N3F/ARJmnkgOQH8
         vj2bnfswLgYr/yp9EmO5F5TnTgFhzYGdXV2WcKYblSBiCqP957vbjkRFPFLH882BVLRN
         UgMg==
X-Gm-Message-State: AOAM532c4QN0/K0IdA53O/DQ+xlZsfUb6/UihYERwVknIvUddcAUpOOQ
        7dow4AzFv9KkSKgOFcN2HdnXl4Bysbdx2w==
X-Google-Smtp-Source: ABdhPJzQ9mD3I5idZSzbnacA5s+XRr4GLTRmMmS/Y7Fdrz4KyraBXjLkT8kW8W+vAm/P7aDii5HCGg==
X-Received: by 2002:a2e:7216:: with SMTP id n22mr708111ljc.187.1603930385827;
        Wed, 28 Oct 2020 17:13:05 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y14sm104594lfl.136.2020.10.28.17.13.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 17:13:03 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 184so1073484lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:13:03 -0700 (PDT)
X-Received: by 2002:a19:c703:: with SMTP id x3mr502126lff.105.1603930383060;
 Wed, 28 Oct 2020 17:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201028142625.18642-1-kitakar@gmail.com>
In-Reply-To: <20201028142625.18642-1-kitakar@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 28 Oct 2020 17:12:51 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPX+fadTKLnxNVZQ0CehsHNwvWHXEdLqZVDoQ6hf6Wp8Q@mail.gmail.com>
Message-ID: <CA+ASDXPX+fadTKLnxNVZQ0CehsHNwvWHXEdLqZVDoQ6hf6Wp8Q@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: pcie: add enable_device_dump module parameter
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>, verdre@v0yd.nl
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 3:58 PM Tsuchiya Yuto <kitakar@gmail.com> wrote:
>
> The devicve_dump may take a little bit long time and users may want to
> disable the dump for daily usage.
>
> This commit adds a new module parameter enable_device_dump and disables
> the device_dump by default.

As with one of your other patches, please don't change the defaults
and hide them under a module parameter. If you're adding a module
parameter, leave the default behavior alone.

This also seems like something that might be nicer as a user-space
knob in generic form (similar to "/sys/class/devcoredump/disabled",
except on a per-device basis, and fed back to the driver so it doesn't
waste time generating such dumps), but I suppose I can see why a
module parameter (so you can just stick your configuration in
/etc/modprobe.d/) might be easier to deal with in some cases.

Brian
