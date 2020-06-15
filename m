Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0962A1F9F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 20:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgFOSY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 14:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbgFOSY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:24:26 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE147C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:24:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id h185so8175060pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kL5fDvG4ZhHsqS6/JTau2TGYJMkRI7BxKtBn52qaxrY=;
        b=gFL4iL/ivbYpnQlUdzI4BSbfnQ1YFPVKAEkwrc7HuVUBUw2UFiIePFjG0eD5T6vP+Y
         di24Rvk6Qy+LWFDcK3UdCVsfkba5O12a5IOjwq7Pi92mwi2tGu/GOKh1Wb1sJ0TudnDY
         +Rf+6n6dF3+WvtmGDeNERPco3zbTd+sTQuipA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kL5fDvG4ZhHsqS6/JTau2TGYJMkRI7BxKtBn52qaxrY=;
        b=IpCe758kS1TywIPsx5pC+7fna3XjI3/pCqurv7SHX70ltw/00XS+1a8wuBcK5PgXdT
         B0GU8qN817u4lzT8hb+UATujpK0ws4tt4MxjNhB1VRqaJI1xzhCVRizbdyOU5h52MXur
         0aGVn1G/Eh6zl0swJYcm7Zi5Ko+hLW8k70jLpbcOgPo8UFgmMGr93B2X9SaWBkonkj5Q
         ws52QNO23LB5V6xsSe8BmBllwy5dQwqZVByc5VWgMLg+8/fKsVkRI/RpeTjIbRpBzNTB
         4ZnMl3UpvRvhstpQ5V5jHztA7WcYutidN/GaovDzVsOoCgyuOqp93wYhg/ZZCkc/gPmh
         N1EA==
X-Gm-Message-State: AOAM5332vJqaJT6tVkZZuLPYlIgOnS2aM35eeDYZ5RrNb4TUKLrU0x1r
        jkxX2kaKcvEUhJpsf4wQc7+CfGN1coTR0g==
X-Google-Smtp-Source: ABdhPJxCXhvGZKRflg/R5Ap4Zw8CEn4PBJLN04P/HCgQjRmuOWZrpGbe5Qwkt5DK+EnPq7DbBMb0hg==
X-Received: by 2002:a62:fc52:: with SMTP id e79mr24316601pfh.5.1592245465482;
        Mon, 15 Jun 2020 11:24:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm14551594pfi.183.2020.06.15.11.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:24:24 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:24:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 29/29] docs: fs: proc.rst: convert a new chapter to ReST
Message-ID: <202006151124.65739D94F@keescook>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <cbf1cc9a0cae1238aa3c741f0aa4e2936fd3fd2a.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf1cc9a0cae1238aa3c741f0aa4e2936fd3fd2a.1592203542.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:47:08AM +0200, Mauro Carvalho Chehab wrote:
> A new chapter was added to proc.rst. Adjust the markups
> to avoid this warning:
> 
> 	Documentation/filesystems/proc.rst:2194: WARNING: Inconsistent literal block quoting.
> 
> And to properly mark the code-blocks there.
> 
> Fixes: 37e7647a7212 ("docs: proc: add documentation for "hidepid=4" and "subset=pid" options and new mount behavior")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
