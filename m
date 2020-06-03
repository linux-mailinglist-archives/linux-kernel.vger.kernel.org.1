Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F71EC61E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 02:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgFCAQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 20:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFCAQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:16:15 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE94C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 17:16:14 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so445129lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8hJYQ+rT235Ea6JWRxsMjDChbaKBs3WgPV6XuNeVEM=;
        b=AqPBITwj3FjR7rqIyNNFayXEwz1gK6Yyxnoa/T4EKJ6pNVfWvXrETDdXLt5zGbypPK
         Uz5MZjGmT81Mr2dIdb/mJYnX6zyDZyBsOEhOF7n8VpU8U5lBryFrpixulJ/sw0Cnyoqx
         74HvIbDUSSYZE2PXXHNiTP3+ZHPNGyk9AGJ8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8hJYQ+rT235Ea6JWRxsMjDChbaKBs3WgPV6XuNeVEM=;
        b=Z5epzN1wz5V+GuY41sSXCGEkHI8e+P6JvHMP0VYfxpGH8F7xdbQ1nZ4mgPXEuPIfwd
         NJOqxDvAAwOnVplY/laiU/CiX1lMc8DWgzvHGLfhcwAzPh32pjF0IGMn1H1xtx8WbzvQ
         lNBGrw8gZqdttusRNRHpk8073oTp1Qz1nTdlQM/wgJdosturTIzg9iEygM9JhimQDLj2
         Kl6OEw0bUgs77G1VpgynDJSY0Cj7JYwf/K1vyEBGbkvGSspAzVLY3Ve6rd+In0miB/ps
         rpbuKlSCGhUq4jlKhfRjQE4UKSn0QdUrEF0LeRU/z+cFKtbozkc6biI/GT7+tD4rN4l2
         OA6A==
X-Gm-Message-State: AOAM530cBuERao0mBIUWFSBtsKYEWy/iCefy1aIhwoG+4tcDTBlXcRHy
        BIkzWKXw4DXAzpZKtNw7OHKhmFItcWY=
X-Google-Smtp-Source: ABdhPJxeDcnONiYriAQ80KIUMsWBSmLfFXMoeqowSdZ1RD9b29Imj+vgUKkr+t3jjhZXIMO1d51IRg==
X-Received: by 2002:a2e:90d1:: with SMTP id o17mr724671ljg.206.1591143372771;
        Tue, 02 Jun 2020 17:16:12 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 66sm170802lfk.54.2020.06.02.17.16.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 17:16:12 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id z9so428242ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:16:11 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr681936ljn.70.1591143371526;
 Tue, 02 Jun 2020 17:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQqnAG5DxvoQKa643d06rDTVtHVFEj5arCsHwyoamCckA@mail.gmail.com>
In-Reply-To: <CAHC9VhQqnAG5DxvoQKa643d06rDTVtHVFEj5arCsHwyoamCckA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 17:15:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzabBsjeGyjE9jHDiLT+CbCYhkLq8xUyWemue2zohrew@mail.gmail.com>
Message-ID: <CAHk-=wgzabBsjeGyjE9jHDiLT+CbCYhkLq8xUyWemue2zohrew@mail.gmail.com>
Subject: Re: [GIT PULL] Audit patches for v5.8
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 5:49 PM Paul Moore <paul@paul-moore.com> wrote:
>
>       Unfortunately I just noticed
> that one of the commit subject lines is truncated - sorry about that,
> it's my fault not Richard's - but since the important part is there
> ("add subj creds to NETFILTER_CFG") I opted to leave it as-is and not
> disrupt the git log.  If you would rather have the subject line fixed,
> let me know and I'll correct it.

It looks a bit odd, but not worth the churn of fixing up. Thanks, pulled,

                  Linus
