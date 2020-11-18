Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0B2B7A55
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgKRJ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgKRJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:26:43 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B24C061A4F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:26:43 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id ay21so1251114edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJZDTmGQCMRrHgGITDBSvnJ9kgXzD9M/FJ4rVuEjmck=;
        b=L/zm4azh+KpuVC1kELj+T04nSVtHuTCWbPnVfKg9mM97hpCSOrs28XHTYdr0o1D7d3
         o1FlxqO644ilGsd0vpHzjDSG+Sh+qgErbM3RYB499TtS1wI9bSTeDFy1GZK/P2aoWyyq
         SoS2WAZFNwOyRZBm3xuYJ3Z3lDeSwQgbxip89MM3g5q5kTyZqjtNvKngAqBbnMS7tqYd
         46oOwNxrXqp+R0fVd9hcy8ekap0HgIEeB+38jzawdpWcdlUlhX8gfcI4yJlpGLh1xvvU
         cChqFz6ZBACpycxFbyo7qXrKuq17b/CByaFJX2NKNhbgXQxFo/AVTXruCVa4fP7fUjz8
         yA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJZDTmGQCMRrHgGITDBSvnJ9kgXzD9M/FJ4rVuEjmck=;
        b=MBFmRXn9fGd3UXcwlmjC2bVo4KCzlVCKU6FNL6IMtqUaFRgHUxLxBXupEVU/rbXzaV
         XIqPCC/pcoHzlP2xA7fD9YWKYAwaYaxOmP6H1S239kmPdtpBimQyNDgTWOtxpAJcV4MC
         Gqh9hit+7xFsvcV+7YSrqw8Rym41l0CFjY7GM63HQSBeXCfwxJo+w8QyaLvO9ihMO7Tz
         JR6fkKLb7vNAS9t8RD2m9DhjJUNZkvh7rXO0M3JRVdsBgTFtFErppqZn9oBwICxPNGWP
         F8D+vnK52X9f/bwpkHeuC86zRxk8Td2C63pwApsvzfqHGgmCg1UH9h8eFS/GnYXgPE4L
         8vQQ==
X-Gm-Message-State: AOAM531uWF0B9nvTGANIU4dsB248yMt8A4+6e0FQzjnrGKqQiYlA8fki
        SaOeQFrqRvfaP5JYmjwqJJZDNo6qufyslSkYSbPj1w==
X-Google-Smtp-Source: ABdhPJwxLU/BF5kVXKEXzqyaTfPwvnucxLiPgj3g7d2ft6NwROtC2mysLW+buBXL/VQ4fRYDhktE03vGdsoWkwgNuMc=
X-Received: by 2002:a05:6402:8cc:: with SMTP id d12mr25215161edz.134.1605691601760;
 Wed, 18 Nov 2020 01:26:41 -0800 (PST)
MIME-Version: 1.0
References: <1605566782-38013-1-git-send-email-hemantk@codeaurora.org> <1605566782-38013-2-git-send-email-hemantk@codeaurora.org>
In-Reply-To: <1605566782-38013-2-git-send-email-hemantk@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 18 Nov 2020 10:32:45 +0100
Message-ID: <CAMZdPi-qxKgs==kXXuSY3Y-GTfcGb7WjQuzn3tXMt2NZNuzriA@mail.gmail.com>
Subject: Re: [PATCH v12 1/5] bus: mhi: core: Add helper API to return number
 of free TREs
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Network Development <netdev@vger.kernel.org>,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 at 23:46, Hemant Kumar <hemantk@codeaurora.org> wrote:
>
> Introduce mhi_get_free_desc_count() API to return number
> of TREs available to queue buffer. MHI clients can use this
> API to know before hand if ring is full without calling queue
> API.
>
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

In case this series get new comments to address, I would suggest
merging that patch in mhi-next separately so that other drivers can
start benefiting this function (I would like to use it in mhi-net).

Regards,
Loic
