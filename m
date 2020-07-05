Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99776215067
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 01:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgGEXrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 19:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgGEXrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 19:47:21 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAEBC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 16:47:20 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g139so21589424lfd.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPQESZvLzBCiWC6EG5DKB+ET67N7b5/1MLY//mTPGek=;
        b=WNPph1Rnfmu9y42wUJuMYOQV7Xxxcg/Ad/Vu9/PaQV2YOJMQVNnHf0Fs88lAv3CnFL
         9xR+pATJo3x4tN55YQG/TXCBad3pmyGqmA5fPyMXpF+qlIb3XLN3p5G0wVIv7tbvr1Wu
         5LKC9INYTOeYYMgE0O1rzTcifWTtOb9YDy9J4KjiAtkFhgFxNCnntWdneCq0V7PFMz0H
         lkd0TdbUniexNcGPTGfLovLYCeYAjT6NCwsPjmeDgOHAR7YTu0EKLqllwIaaDjs6EO/4
         ynDAM1q/wv7+wIfZNT6VIbEjQdVwjvTTfbqnvs8V9HBvv4a8HXZ5SV/jUJI+YVlJ7xK2
         bU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPQESZvLzBCiWC6EG5DKB+ET67N7b5/1MLY//mTPGek=;
        b=jV9fzjKQBua2GvxnR9z/1rBaYh4uuGzcgWPh1E+ksbLh23tsEsASUQwdFul118rVSz
         h3vBEnh3G3ogHwCXKygmvWWfnaO3QRqai9NxUIOcQtzS8nvUmPMgVXtbZw9k9IgLFtHv
         J1QHBCvWA/y3cc+rgkOB1NRQcvEcZ4EOq/dWVTvA38JE4TYo9Woh5wXk/77vqAHKxNWN
         H2CnO9A3fKFe5L2LaSbgyie3/S/gYt8JX+IHRoCwAyARwoBjlf7u/1qHLnyccmOtKSoG
         4VNumbRIMEYYeHs2LEdH4+HhSuSiiM9X2J+bDxxAKWK/bcY6oSGM01EvvEe7k/METc1v
         SJZw==
X-Gm-Message-State: AOAM533Lg5bvuuTq9cLOwMbSHYHLj4udgQf3bOn/S8hMz4yo4EkVTQYu
        tZFs0Hkj+BH6rYcfnPg4Iuctg32aXqoCyV38bCQ=
X-Google-Smtp-Source: ABdhPJzSw1PL3kqgRpbbKJVwUy9vBzKOUowhbkDVg/jU/+Mzwe3KjxXCyBTInrASBs/BoC7LUWZ1diVxdKI2qtUtk4U=
X-Received: by 2002:ac2:5443:: with SMTP id d3mr28104550lfn.121.1593992838852;
 Sun, 05 Jul 2020 16:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200703065420.3544269-1-daeho43@gmail.com> <20200703141359.GA2953162@kroah.com>
In-Reply-To: <20200703141359.GA2953162@kroah.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 6 Jul 2020 08:47:07 +0900
Message-ID: <CACOAw_yweR--34vBXBV07xEGxGhO2r9o_XYVw6h9dMP=C6zp5Q@mail.gmail.com>
Subject: Re: [PATCH v3] f2fs: add symbolic link to kobject in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No Documentation/ABI/ entry for your new sysfs file/link?

This is for adding a symbolic link to a pre-existed
/sys/fs/f2fs/<disk> directory and it means /sys/fs/f2fs/<mount> points
to /sys/fs/f2fs/<disk>. I already added the description of this in
Documentation/filesystems/f2fs.rst.

>
> And what does this help with?

Some system daemons in Android access with the pre-defined sysfs entry
name in the json file. So whenever the project changes and the
partition layout is changed, we have to follow up the changes and
modify /sys/fs/f2fs/<disk> name in the json file accordingly.

This will help them access all the f2fs sysfs entries consistently
without requiring to know those changes.

>
> If it's really needed, why don't we do this for all filesystem types?

This is for the daemon to change the mode of only F2FS with the power
hint of Android.

>
> thanks,
>
> greg k-h
