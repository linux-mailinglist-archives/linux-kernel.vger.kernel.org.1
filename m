Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466792C61A8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgK0J1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgK0J1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:27:13 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A11C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:27:13 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 64so4806198wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SmNkndM5ibQOBO+98euVdeB3ddUlhWQyKWraShvz7jg=;
        b=LvPHLer8vECGyXFh/SrLld8TBNxi1sRarddvQyRUGoxQIel40ysPlhPSE0VqHnuYj0
         IwrSEsBkwNaXjsg+fCMufHIoYL9+BvAMCXU1p77YR2f1lx8m0Eqvc+ZTAAdtK473CC/7
         BW8cxqC/eSGHAkony9fdpr86X2T56zwvrarf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SmNkndM5ibQOBO+98euVdeB3ddUlhWQyKWraShvz7jg=;
        b=D+fe0vXbFE6KegSrDQfSvvRSFMTtTLfmRkU5Bittbo/705TPoeCvO1u/EIinLgHnzf
         IkpJfBf3jjjMfK2snqdonRMDqfaSwSFVYVORDI8rhAwVP0aFuUHEPXA25R9W65H7LCAt
         LP/uv8/K1MtPEZA/O8MmPwVzQRjk+Md5gX6H0ezbiuYuDyogjVCndKpoEUEuuXm5lTX6
         5D5U8MIJ3nZBxbCPRRJDFNabzyufPKtWODMva0tfBQ+McWhz/osQhQK/PTuK7vSIoBGx
         ngrOQcYsiHvp+GmxOnj/VjvS/tdwFjM9Xobfcx3tSFYGXjq/KLTryMmGKhO9UfOf2Zyb
         yhqA==
X-Gm-Message-State: AOAM530A/8pRDO2QyRGX0+GLC/9jXtoxZVT3fo59leL1AoTLb0ZnqVTW
        ffyix/F9138qidvMjirJQcuBaQ==
X-Google-Smtp-Source: ABdhPJwHp7aDcPgXPMSK3hbvaRot1sfBAfEZbk6OFHwbn11ztPHhMhlnCEpj+Jb/AsdYNiWmlYF6ag==
X-Received: by 2002:a5d:658a:: with SMTP id q10mr4258898wru.115.1606469232278;
        Fri, 27 Nov 2020 01:27:12 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id d16sm14491583wrw.17.2020.11.27.01.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:27:11 -0800 (PST)
Message-ID: <8ab56347997ca2f849dc9c3127965795511883d5.camel@chromium.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
From:   Florent Revest <revest@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 27 Nov 2020 10:27:10 +0100
In-Reply-To: <c5af620d027aba9c3cdf2d642c3611f908638a3c.camel@chromium.org>
References: <20201126165748.1748417-1-revest@google.com>
         <CACYkzJ65P5fxW1bxVXm_ehLLE=gn6nuR+UVxYWjqSJfXoZd+8g@mail.gmail.com>
         <c5af620d027aba9c3cdf2d642c3611f908638a3c.camel@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-27 at 10:25 +0100, Florent Revest wrote:
> I prefer Yongonhong's suggestion of having two helpers.

Argh! I hit enter too fast! Yonghong*, sorry :|

