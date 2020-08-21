Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C3124E2C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHUVlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 17:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgHUVld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:41:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CAC061575
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:41:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q3so151109pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=F0yFmC4o5irkuTq78iNlYXHaTPjakIi9tEh/7+FUKIk=;
        b=CI3QuJFhdas1uPHKQRZ/jnrLw4Kr/inX1N05JNTX2u4ByKSVQl7LczGsrnVPCPZeNI
         oCkvnCOnHMb6jGpU60zvsfhuOPVF0TXbU3S+cO2MoPet0oRsOQMcrmQFPxA/+nvPRuge
         23CMJCS14hWv/fFqbupoXBwrirLGUqkxEcbgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=F0yFmC4o5irkuTq78iNlYXHaTPjakIi9tEh/7+FUKIk=;
        b=j+PpktV7YEmBa5H9llnTRmzqAL5PJSq8RiY5LyHekNrX1RtPKjW0V6crwMvNFtXA5t
         KW7Vs/IFGWHavviJddqncdS/bVmH0m+zOZ+cbGH/bS1t0gR6D9BL8WadgctTNaBTusr3
         1Ir5k8XqYBN/CcLfFhGIBGvJbqY/srJtx/UsjFVjSE/FoL28IEsrewgoINcU7Ad+yubf
         Ghhsag5nGLu486wSSRXQ27O4NBRiFtP1hCqBZlsveoytz53t7QHBO1W8T3EJ/Qey9YBV
         Vd20W/ZgJaTBQHYOdNDRaOtZECdmGiDDoew7jCLSjxrkDgeS/qNzgjub42BGP1zGCXwg
         iHyg==
X-Gm-Message-State: AOAM533038oMor3nKbBuvaxTih8HmsuwXrV3RfIXFD0k821IMIZp/ssf
        a/3jYotnYuJu8wGs8lqrhwrzQQ==
X-Google-Smtp-Source: ABdhPJzTcvJN90Jptay3sh02aa3TTUvk2fKeSuuIeSH9liKZQG9ZvAd2U0zTN9VfhtPg9+tfKYribA==
X-Received: by 2002:a17:902:9f92:: with SMTP id g18mr3993751plq.83.1598046090694;
        Fri, 21 Aug 2020 14:41:30 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id y79sm3469576pfb.65.2020.08.21.14.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:41:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200821204921.32536-1-sibis@codeaurora.org>
References: <20200821204921.32536-1-sibis@codeaurora.org>
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME flags
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rjw@rjwysocki.net, agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, pavel@ucw.cz, len.brown@intel.com,
        rnayak@codeaurora.org, dianders@chromium.org, mka@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        khilman@kernel.org, ulf.hansson@linaro.org
Date:   Fri, 21 Aug 2020 14:41:28 -0700
Message-ID: <159804608868.334488.2486130699850456264@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2020-08-21 13:49:20)
> Add GENPD_FLAG_NO_SUSPEND/RESUME flags to instruct genpd to keep the
> status of the PM domain unaltered during suspend/resume respectively.
> The flags are aimed at power domains coupled to co-processors which
> enter low-power modes independent to that of the application processor.
>=20
> Specifically the flags are to be used by the power domains exposed
> by the AOSS QMP driver linked to modem, adsp, cdsp remoteprocs. These
> power domains are used to notify the Always on Subsystem (AOSS) that
> a particular co-processor is up. AOSS uses this information to wait
> for the co-processors to suspend before starting its sleep sequence.
> The application processor powers off these power domains only if the
> co-processor has crashed or powered off and remains unaltered during
> system suspend/resume.

Why are these power domains instead of some QMP message sent during
remote proc power up? If this has been discussed before feel free to
disregard and please link to prior mailing list discussions.

I find it odd that this is modeled as a power domain instead of some
Qualcomm specific message that the remoteproc driver sends to AOSS. Is
there some sort of benefit the driver gets from using the power domain
APIs for this vs. using a custom API?
