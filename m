Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC6221669
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 22:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgGOUkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 16:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgGOUkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:40:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DB8C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:40:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so3673666pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3RdpnHt4YFQNegHM71xCSPo+5hGEKA55j9DzkLX+zEI=;
        b=W6JWWMnCCKRoZOrZTqxAVNCpWdse7JHrhl955F5ofkWIbY8yj0WiYEYIrzGnCpQmPr
         nebzAR1cLp77bQPydJtMWmGvGL1DOx/5b1SD2FJ+owpHkt8+SixM1Gqmi5haJ+ZpVK/l
         ohTNaS/ycfxJ7NhhCYIL+fq/TdpwR9jTHXNUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3RdpnHt4YFQNegHM71xCSPo+5hGEKA55j9DzkLX+zEI=;
        b=amQo3DE8itAZuwU+eNbUL3kSgbDMgtQescZ2f3eJAZ1NIpXukrjWAAQrVQsQHmvGUj
         64PhmXEdcYgmnl1x6qDGhK23Z8V9VYYhVw9ptcPOVntYMtxz41uVkB4B2jY3yHMHCmrZ
         d2OuBOqCePuZetsm+7xhmb52MhDhfxRdyORpJWEI/CFfHoGIJEqsr5/Ci3nTsrznd80I
         /vGqrGSGIzlVahptF1bVa2wNkclWNn/HVYeYq/8xKCDT/5Jn/AIHo4zsffy9Je5UmX9b
         BidssG84YS/g73HBnr2jGAdgrB3sXs4EY2CyQCJQyK4YSM5Mrd6JYeIsJVXTF52Fu5Cz
         mOIw==
X-Gm-Message-State: AOAM533v6c72a1B5urvuH5cs0Cos+WMwIg4pZvFHJTrv8O57093vcEt2
        NcVFU4M3uezfN2fqT0hYmUJgAw==
X-Google-Smtp-Source: ABdhPJy0QMC5q+2qYD6o7SHOebREIiw8ISqB8EjezF/XGzbblfIdGbOr3hMolHLPO5Yp/fgvt7Nt3A==
X-Received: by 2002:a17:90b:8d7:: with SMTP id ds23mr1507273pjb.148.1594845616072;
        Wed, 15 Jul 2020 13:40:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 66sm2720207pfd.93.2020.07.15.13.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:40:15 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:40:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 7/7] ima: add policy support for the new file open
 MAY_OPENEXEC flag
Message-ID: <202007151339.283D7CD@keescook>
References: <20200714181638.45751-1-mic@digikod.net>
 <20200714181638.45751-8-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714181638.45751-8-mic@digikod.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:16:38PM +0200, Micka�l Sala�n wrote:
> From: Mimi Zohar <zohar@linux.ibm.com>
> 
> The kernel has no way of differentiating between a file containing data
> or code being opened by an interpreter.  The proposed O_MAYEXEC
> openat2(2) flag bridges this gap by defining and enabling the
> MAY_OPENEXEC flag.
> 
> This patch adds IMA policy support for the new MAY_OPENEXEC flag.
> 
> Example:
> measure func=FILE_CHECK mask=^MAY_OPENEXEC
> appraise func=FILE_CHECK appraise_type=imasig mask=^MAY_OPENEXEC
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Acked-by: Micka�l Sala�n <mic@digikod.net>

(Process nit: if you're sending this on behalf of another author, then
this should be Signed-off-by rather than Acked-by.)

-- 
Kees Cook
