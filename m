Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC577285428
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbgJFVwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgJFVwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:52:45 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D954C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 14:52:45 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 5so64600vsu.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 14:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fBB2dN7PdVdzeo2GaMVbE6RJ04Kn9xtAgetaWZ+zY8=;
        b=j8ntnkFTswigoDlM2kyeqSJnc2fj4esZFkzvc+ruGDYe/EKQ32ogWQakV7iq525v7z
         bR0JIdfXxMtuGKKbkC97ikiGOh7EOcbTBoXZXD1aIuwSEEFV/PdWgWZmSjmtXw6A172S
         AShlaJNKVdo9XefO6oV2tFPa9wc1RaopZv+K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fBB2dN7PdVdzeo2GaMVbE6RJ04Kn9xtAgetaWZ+zY8=;
        b=K4pqfBSmyuw9ESIUdhasbMVkpiVZbpHWe0xnXS/I0HDNWcRm6meERVb/SWLI7hRhdi
         +EkPQpVvgaThDwcP/ZeyrUatIKhmux/60lM2d6tN3lrI9Y7144ZOrQGB7RikdiviUUWQ
         dkfb7xuDkwvf2e32o0MII0zHKqLnpC2yt3rwY//ort+Qq5QkRwzy3spRc2h1jf0jZw7Z
         y/GEdnLfnctjWvbM/U1zpHP2hOwPr/rbPwdE350Nsi+VzgbX8ZgKMKitg2NsPIlgxB4L
         tENZiRFGlG+jyqYsURecyUqxP5NqtiJ9Y5Aq6YwvxfHWZv8HbA8ddocjJx0BkDdsR9vv
         eo2A==
X-Gm-Message-State: AOAM53239A0o2Z+x/U/0fiMM8U5f9LLep0B0OW6uk1AhDAWVTxgOK7On
        KMKsavrae9Jhd1C8lyyygv6NuqvEGexTlL3yek5RiA==
X-Google-Smtp-Source: ABdhPJzneCJCHYv0M1DrM76Ar6uigcbc3WG3NIajdN24GCsJGLRUKR6frfTDFPPkxH5b41lK85jBVXzoSJwinIYY7OI=
X-Received: by 2002:a67:f857:: with SMTP id b23mr57260vsp.10.1602021164282;
 Tue, 06 Oct 2020 14:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <1601997621-12056-1-git-send-email-bgodavar@codeaurora.org>
In-Reply-To: <1601997621-12056-1-git-send-email-bgodavar@codeaurora.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 6 Oct 2020 14:52:33 -0700
Message-ID: <CANFp7mWU6DEuHxQqq+hnWfCnqrJLo=kY41J+uM7AfjEpTnzH4A@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Wait for timeout during suspend
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

On Tue, Oct 6, 2020 at 8:20 AM Balakrishna Godavarthi
<bgodavar@codeaurora.org> wrote:
>
> From: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
>
> Currently qca_suspend() is relied on IBS mechanism. During
> FW download and memory dump collections, IBS will be disabled.
> In those cases, driver will allow suspend and still uses the
> serdev port, which results to errors. Now added a wait timeout
> if suspend is triggered during FW download and memory collections.
>
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
