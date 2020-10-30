Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F992A02AF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJ3KSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgJ3KSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:18:54 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADF4C0613D7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:18:53 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k65so6136828oih.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSrgT+Sq6ixZqGRM1ApDzYbdNLSfueKKt5jrYnIpTKg=;
        b=J/brQsIEXjkMtFsYYqBCMbN7+7Cmh0sjVyNHa6GCk49DXyvdvhr/CvjKzFrLjPezzh
         Ks4w2XDcjvzJb+PPrLEQgUhcZX1Jm9QbzrgXNMykyjrC8K2BKrEoWVHTDkLX1pQBkosi
         Ta+c14qVOgbtbcqoDC7k92+K9+TwjtNqNP4zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSrgT+Sq6ixZqGRM1ApDzYbdNLSfueKKt5jrYnIpTKg=;
        b=r7c1SOGxhevVVqzecbH/z91VrVbfBo3F+6XfUAO00JxbOb34cPrRQzlqxjZ9qF5ayh
         TLj/sJDeq6EdgHQ6H+3JcQ44EDijS8IlZA0qsPWFUaSacNcfIibi62dXvXHfoaXBiZ6E
         RUjzWlXGj2hYfGPpDS6QcW9M1S/2gDCsSnolT3MS47ZnB6rKyRLoxGpnn8KrKkIgIcnW
         GjXp5KAnD+0Om0McGmdHEaEqBKoGHTEr7KFAo3kKalXLttoy3TKNg1auoXlLAjLTQpdH
         ZuzKOU2soWlZLPb5qMXf4uPlksKSkCOxKENKbZLQDOrFixOksrXmbz891flWo0noPVby
         T75g==
X-Gm-Message-State: AOAM530qNR4efeWXjvcqDMu2k6+OjbsnBgC8jkNHYJ0RDOTa7cMBUOGA
        8ja8Ie+tfQXgw9+vFc9JiVWpEG0dLGiBYQ==
X-Google-Smtp-Source: ABdhPJwgGvy+HnckrKEQa4hvCFrZAZkBo7jWCOh2wMvLJ22MWxaM7HcTJ0Nf49G/CeFp70L5P6rlxg==
X-Received: by 2002:aca:580a:: with SMTP id m10mr1025045oib.122.1604053132492;
        Fri, 30 Oct 2020 03:18:52 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id m13sm1213737otn.20.2020.10.30.03.18.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 03:18:51 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id m26so5059316otk.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:18:51 -0700 (PDT)
X-Received: by 2002:a9d:eca:: with SMTP id 68mr1003531otj.141.1604053131232;
 Fri, 30 Oct 2020 03:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201013124428.783025-1-acourbot@chromium.org> <20201013124428.783025-3-acourbot@chromium.org>
In-Reply-To: <20201013124428.783025-3-acourbot@chromium.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 30 Oct 2020 19:18:40 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXpXEPsgkWXAo0p3u_zFyYk3kYqKx3=+G6XEcGcsKCEYQ@mail.gmail.com>
Message-ID: <CAPBb6MXpXEPsgkWXAo0p3u_zFyYk3kYqKx3=+G6XEcGcsKCEYQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] media: mtk-vcodec: fix build breakage when one of
 VPU or SCP is enabled
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 9:44 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> The addition of MT8183 support added a dependency on the SCP remoteproc
> module. However the initial patch used the "select" Kconfig directive,
> which may result in the SCP module to not be compiled if remoteproc was
> disabled. In such a case, mtk-vcodec would try to link against
> non-existent SCP symbols. "select" was clearly misused here as explained
> in kconfig-language.txt.
>
> Replace this by a "depends" directive on at least one of the VPU and
> SCP modules, to allow the driver to be compiled as long as one of these
> is enabled, and adapt the code to support this new scenario.
>
> Also adapt the Kconfig text to explain the extra requirements for MT8173
> and MT8183.
>
> Reported-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>

Fixes: bf1d556ad4e0 ("media: mtk-vcodec: abstract firmware interface")
