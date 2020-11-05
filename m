Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6D62A8A5F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbgKEXE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731860AbgKEXE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:04:57 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8592FC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 15:04:55 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id b1so4701938lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 15:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4j2thf1GAZ1ka8io0eNzlpqFwwJDlIi2s7ciYBV0eU4=;
        b=WGZ1/WaGrUVgot/BDxPvFVceIUhUFt+D1WRaHJIQS9TYLG8jzDRegA7Y1XrgoLMcSj
         HPxRbIIrvTH2CVYrYfLbfplLZgE8zwk3iXdAo35yhqDyPl/jDObNpeJFADA/RFVTpWFk
         IKTfDUUtpoe+7LCUORJnp/GA7ZV6Qu30nVEdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4j2thf1GAZ1ka8io0eNzlpqFwwJDlIi2s7ciYBV0eU4=;
        b=lA+daQ+mcBucRQPQPlvhKx0L8vzrtYMQUWEHqut3sByrOjLcFn9rtntNRM854y3a9z
         M5kbqP5gZER5Y/YXczsKqsUlNSffTOOACvT0EpoztCpPONh/Rywvookc5iKVnx0OprUQ
         32ljUhBFX34pk6mP9wqWT/QoLnBgBbMr/oULMYnHOysYhZpvaStM5YDCK9YuvZAN3FEH
         9YTJF3dNXJHp+VqFoz+wggKBuQGRIqKw0tocRvyOtqW7BCFTrf24OAbkg0Fi2mTSR7gY
         w+F0KtQoRZ31JMI6NHX97Fah+BDhcanf0pbTIc502aGpl55yonNsuLfpAw2Nrc+p8SZ/
         3S5Q==
X-Gm-Message-State: AOAM533LD6t2zMG00OZSLp4zEOgspD5ClPIr14DcAbPxqHO2B4iYVjpy
        bCFzjClt1zwo/uPNCmowJTdkZ8u7TSs2qWVDjjg9R0GItDFJZ0VW
X-Google-Smtp-Source: ABdhPJxYbGXp9VC8uN2+teG2uD171oxhvM4AaLAf2mN7xswyTbanJNwbF5Bqna3uTqVrJXwaBRhX3kHPxcVj22xp5h4=
X-Received: by 2002:a05:6512:3102:: with SMTP id n2mr1801431lfb.153.1604617490774;
 Thu, 05 Nov 2020 15:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20201105230221.2620663-1-kpsingh@chromium.org>
In-Reply-To: <20201105230221.2620663-1-kpsingh@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 6 Nov 2020 00:04:39 +0100
Message-ID: <CACYkzJ7efr+riXRgwpL23L+o7_DZpqPk+PxP0eJQZHOU_MxoPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Update verification logic for LSM programs
To:     open list <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 12:02 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The current logic checks if the name of the BTF type passed in
> attach_btf_id starts with "bpf_lsm_", this is not sufficient as it also
> allows attachment to non-LSM hooks like the very function that performs
> this check, i.e. bpf_lsm_verify_prog.
>
> In order to ensure that this verification logic allows attachment to
> only LSM hooks, the LSM_HOOK definitions in lsm_hook_defs.h are used to
> generate a BTD id set. The attach_btf_id of the program being attached

Fixing typo (BTD -> BTF) and resending.
