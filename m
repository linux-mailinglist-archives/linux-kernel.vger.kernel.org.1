Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A465C2B74DE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKRDgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgKRDgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:36:04 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA2C061A4F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:36:04 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id js21so331048pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=diUqtZunx/UjcqbbhT4Je7Zj6fu6UKGAwXhMW5mk2Gk=;
        b=AMLoDLL3GfVM1STbX9/xTk6VliNiJr0YwOLeAg7i54QP7EoCz7VMk955TElCpWmwiI
         j9N2sIXacWcnmimKGbxoHCEXSLpD7ZmjhUwdUKU1vs/FXxsrdOrgIPsrl/2t60juYxcB
         DDIALijMpGftZLW1UXskLBZsWao12HjQTBWXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=diUqtZunx/UjcqbbhT4Je7Zj6fu6UKGAwXhMW5mk2Gk=;
        b=YMkJuK/1WJlOIhc+Zi5PFaQddJ1cK5AXNrZmCzXZ6UJhluk8IJN4hXyqWO89AcM8fW
         Ww2l+AWVfzWKX/TjiWzKtlniFAxwuV+m2oV1DYaOpl/82G7N7zC18+6FxpEYhK4PBdpR
         zfdV1vJA3dqE/6OvLfA0UfoYo3exCGX42gaXmTuBJLlo7YevZ8Oc8RC63j/6FCLXqPkc
         3DOYF3t+vMd8WbihSkan19W8qHE23797k0AzHOIiMwPnXFqhN+9UvWvGEiZGhLkVk7am
         bCJFUHsr80c2g/+/NfmfSlDXSIbWfSA4pBHYEL9lxT0GtFn7m6SnNdOMQPOEaRx8KxRd
         rzIg==
X-Gm-Message-State: AOAM5308enboATkrVC/j5q7gSFJJxb2Jaj5KHWwaPV6ZeKNVvx1tbPoM
        elTYtRhng/ptuqsV/dCOvzYZIvsqbRiOOg==
X-Google-Smtp-Source: ABdhPJzVAK808Ab1am3c1X01IMyQIjbNaSWWOanE2FByJ/Gy8QSGdvWbR0gR5vev+WfHCJmpFHn4jQ==
X-Received: by 2002:a17:90b:805:: with SMTP id bk5mr2230390pjb.78.1605670564250;
        Tue, 17 Nov 2020 19:36:04 -0800 (PST)
Received: from chromium.org ([100.99.132.239])
        by smtp.gmail.com with ESMTPSA id y25sm22603181pfn.44.2020.11.17.19.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 19:36:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605638415-24776-1-git-send-email-khsieh@codeaurora.org>
References: <1605638415-24776-1-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH v2] drm/msm/dp: fix connect/disconnect handled at irq_hpd
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org,
        rnayak@codeaurora.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Tue, 17 Nov 2020 19:36:02 -0800
Message-ID: <160567056210.60232.5628804791726356039@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2020-11-17 10:40:15)
> Some usb type-c dongle use irq_hpd request to perform device connection
> and disconnection. This patch add handling of both connection and
> disconnection are based on the state of hpd_state and sink_count.
>=20
> Changes in V2:
> -- add dp_display_handle_port_ststus_changed()
> -- fix kernel test robot complaint
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 26b8d66a399e ("drm/msm/dp: promote irq_hpd handle to handle link t=
raining correctly")
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Tested-by: Stephen Boyd <swboyd@chromium.org>
