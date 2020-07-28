Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C9D230A77
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 14:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgG1MmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 08:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgG1MmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:42:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A1C061794;
        Tue, 28 Jul 2020 05:42:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gc9so11525396pjb.2;
        Tue, 28 Jul 2020 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DRtsTZTInfavsTIFBbELheDvvBIHfMEH5f/reZk59Q0=;
        b=VsACgHGa8pTwFHEe1syWIe4FKAAuDH4vnVoh5IoqbSC5nUwGX+Uwymnu4tHUZQwsrg
         bAUSnlzdkSW1sWtFnErCgmnmuba31mLHaRENDFAmwESavec5sZ6aXXDiPQtWV0dms3Qw
         Q6oLjws9DZOg+yJdfUgQ2cjLnRA2j3MlRf2F6b7LkeIT2Q4Cvlul7qzhEQmGittF7b5B
         dbl8MFRYjimkCmkd/emKJUjTX6NlzCNZvfzCcgWLADP3f75T77L0o7aD8Wn/zj0MIuXv
         MJiSEJCN/rTE+rQQwOSr7Fls1DQpMboJyFot035vkNVIE7Jm1Eg1ub1D5j0obGepaCW/
         Fsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DRtsTZTInfavsTIFBbELheDvvBIHfMEH5f/reZk59Q0=;
        b=a75HFg5WAnFt5+VczUGM4xhmcdCdvkMC3gkrb+MpjKP11noN0hxir1a5gmjpU18t+3
         JD3RXOdFzyu8SV+D2OYuPoNVachri7Ttjdv3zAdtRAhZksc6aeBcyZEVmFe6dkdJaBJ0
         6eayh7vrsYZVwscAcyBJitgNYm0LU1A1YuDFp7TLfxSjXBa9/CukBbi1XwAr7nRcriWb
         ZQHWq1oVOi4WIIfMqRtzOMxkvg5a4/mram5VRfAZG5y2qfgNUKtGEf1RmUx5g4DRC2GB
         /B9RdKtwsTaM+q0LoTrlF+8IAeTKz1QGbR9Fhrf7sW89YwyexbDLJ9SAnv5rrmDOuxqW
         nIjw==
X-Gm-Message-State: AOAM532Ps1NVa0u2R1Tjo1gI4jnLwNPKZFMOV4b/7ZKcgusMi6+gQL/K
        4nnsMjb+KZSIT7cKc2cTGpI=
X-Google-Smtp-Source: ABdhPJxhMEpi6j0i+tSqYk9Nj+n0YJ1omG1107kkNFdUcGdH7M56U3YwSdV3MsWTHnQYdBVVu5JhZw==
X-Received: by 2002:a17:90a:4f45:: with SMTP id w5mr4365834pjl.11.1595940136736;
        Tue, 28 Jul 2020 05:42:16 -0700 (PDT)
Received: from gmail.com ([2401:4900:2eef:ca92:3545:4a68:f406:d612])
        by smtp.gmail.com with ESMTPSA id h6sm3371551pjt.53.2020.07.28.05.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 05:42:16 -0700 (PDT)
Date:   Tue, 28 Jul 2020 18:10:31 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1] staging: sm750fb: use generic power management
Message-ID: <20200728124031.GF1331847@gmail.com>
References: <20200728123349.1331679-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728123349.1331679-1-vaibhavgupta40@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is compile-tested only

Thanks
Vaibhav Gupta
