Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63E02E8C9A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 15:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbhACO1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 09:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbhACO1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 09:27:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42183C061573
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 06:26:53 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 190so14838608wmz.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 06:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daurnimator.com; s=daurnimator;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdyQdxurFTWyieFqx40CmBAoJaRWHmu1pRJJqDh4s5U=;
        b=JHNprKCEMlJgPWrm5Lf8OKHrWDbu4cEkVI6wyETQU0N7Fi8v5Ypp/+nkY/AH2GR/xs
         03HCcW+FEV5VDByHaCH5AKFMjTu24gF7Gq4q8kPosYWDGBO0gm97o3VYffDbTGaInjOZ
         Sa8FL0FLEOy5wkVQ2SJe2vxdz1vPL9rcg8DYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdyQdxurFTWyieFqx40CmBAoJaRWHmu1pRJJqDh4s5U=;
        b=rNFz45Nbw902msR2eQTHZKhKAr8jKus8KbWLp+Y65jG4l2dY+Way/4hlWNGJOrqpdt
         rWotfxC5JfSS/lUuiFkWjqaimvytuIsQkJEG+lztY56Mdf9oR/DZcyrP/+A5TbjYYIUl
         NLRFMY74bnBn0Gp+w/MYWFvyRG7F29Pb2wPX8iUaGcEVB6Ii2zCOSvH0Q2RDcF3qZHGZ
         9eIpUhWGu1GK/UrRbM/G9+oJRMz8Ehu8oS39uxpkKhjk5QMNv0+HWrwMkwy5Ukrv6Sov
         uvcSVZYZsh6XsqQButN7o1ZxA1/Ob2zIq0JjA6ZLnshCxlvd4Hk6ifJPj1/scnAO+am1
         pVaQ==
X-Gm-Message-State: AOAM532awLXC5R0Xe972KeoGdYa4yefUlbQm1HACfdMZrlt70msA/aAY
        mvoIuv5/cojIh/8ZCl+pGV5mIHkARzv07lIfGQyzpA==
X-Google-Smtp-Source: ABdhPJwFlghKT98/Z0lh6E4GwRePMZJ+jb52otf0aNEGyGaXkWUSRiOfpQxV7ZsIBGH2niNmnsTYvIahv/eJODbOWn0=
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr23264936wml.50.1609684012066;
 Sun, 03 Jan 2021 06:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20200827145831.95189-1-sgarzare@redhat.com> <20200827145831.95189-3-sgarzare@redhat.com>
In-Reply-To: <20200827145831.95189-3-sgarzare@redhat.com>
From:   Daurnimator <quae@daurnimator.com>
Date:   Mon, 4 Jan 2021 01:26:41 +1100
Message-ID: <CAEnbY+fS8FXVeouOxN3uohTvo7fBi5r7TQCGBZUmG3MGJhBrYg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        Aleksa Sarai <asarai@suse.de>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 at 00:59, Stefano Garzarella <sgarzare@redhat.com> wrote:
> +               __u8 register_op; /* IORING_RESTRICTION_REGISTER_OP */

Can you confirm that this intentionally limited the future range of
IORING_REGISTER opcodes to 0-255?
