Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24FA300F16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbhAVVng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbhAVVig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:38:36 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD39C061786;
        Fri, 22 Jan 2021 13:37:55 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d14so6632483qkc.13;
        Fri, 22 Jan 2021 13:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z01sMEM1BHDDDy4DLJ6CtoFG8LkWlK4WVMit2bUEiks=;
        b=exvIKpbaQJKw7viwBDrWQchThnS0qFGB2za1m3aBoBnhTpOWkyw3IDmeFY02EwPo8S
         XFvhW1HFLhHvp4VBrzHpAcrjy3rexoNvhBIIN7aVtsUtwLl4AmmDcobelXXt4OMwCsuw
         l4d8/GbHvv3DG3lFX5GvTt6Iq1SnfL7z/3ozFBVm9dwQo6pJwLmKVAg+VvSnRGZ5DM23
         54oO8OUWlUbQDdU09Q4RtKMH9vtDUvPk1AbzFdS4eKVcgElCWo5+z6kF61dvOXiXr2dU
         rJGpK8/dpfFW2AkzDaRFF3eIZOa4dU5Z2vNWK6syiJ0r/JfQVUtdVr+6TKrVp4QD2k/e
         /hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z01sMEM1BHDDDy4DLJ6CtoFG8LkWlK4WVMit2bUEiks=;
        b=CTOlMh5ShoEkcpYbbV1dIqMKwxgO+Up08drEnUIMGcK/jJd+YfBzrunEFBdhaj5nNV
         JpfCW4OUNT2bE12iFKkVnFjtF0ZFTorG/6AyC33M+zsZsr8O1WAkQ7CZblX+YvIC4jnV
         d/mzpuGpL9RflJaaYGsc97FML9tkgJSyAYiPZI7TZDc0CBsP9A+HRFchRyjLHibKobvh
         yMuN3NdgGRE2N6z+7LheNQKTIgvb+zqWUbTlvEJD8CQJPrgNjbf4yUXXnpJNuEy2d4U8
         U8xfpksvUuuR73g6lGxLgnrAj6wQm7IcuI8EVV3FRSi/3BWPtRVXW/+Rwmlj2Cgv9fma
         sI5w==
X-Gm-Message-State: AOAM531R1MD1yWjsDusJb9AFNkPXeZRZNEcwadYZHFMT0Ny1qAbQxkjP
        GoO5zSB4VBXnAyvp6ontMdoA+vJ4ZwOOfyT3BElX0nW+
X-Google-Smtp-Source: ABdhPJyjIS6wf1++BNEZehaFXPvE86D5YfbbVJc2+dJNt/eYNRD17y136paRfTW2VVbvirqQPmfvLC15rRHQkWoHo3o=
X-Received: by 2002:a05:620a:22ab:: with SMTP id p11mr6727935qkh.237.1611351474358;
 Fri, 22 Jan 2021 13:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20210115153901.31052-1-zajec5@gmail.com> <20210115153901.31052-3-zajec5@gmail.com>
 <20210119165138.4982ae46@xps13>
In-Reply-To: <20210119165138.4982ae46@xps13>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 22 Jan 2021 22:37:43 +0100
Message-ID: <CAFLxGvxu0Fd1bgHzuKER_R+kG+jet2oKBUyBFVi9NqDTwv-aZQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mtd: parsers: ofpart: support BCM4908 fixed partitions
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 5:01 PM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
> > Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> The approach looks fine by me, let's see what other maintainers think.

Same, looks good to me! :-)

--=20
Thanks,
//richard
