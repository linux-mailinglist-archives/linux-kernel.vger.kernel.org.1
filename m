Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7CC2AE4D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 01:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbgKKAUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 19:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732341AbgKKAUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 19:20:37 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA57C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:20:37 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id h6so191163pgk.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gRsyoKFAiYsdDr9vFUIknQF83zHV+rgJ/rjEsefe3mE=;
        b=BW8LFvnOIc7NxtiaAB5pesBKEQKPF+1c5mD/tFKnQ5zjxRsoAaahN8+/Zp9540edo1
         mPLR68RuvnW27YFLzO9fW9R2kj59uw628K3z2qe7xJlcvWRnTxKB5z6im2kbvfCmisCq
         sw236ukvht5WKM8LWRjv50SP1IYnIcFLZFH8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gRsyoKFAiYsdDr9vFUIknQF83zHV+rgJ/rjEsefe3mE=;
        b=OF4o+wgdUWg3UmMYA2MXD3xrxtNuIMN0QX3e7APUf191OEP/J+oGJpKmeYWPjkj+ph
         zHMT2T7TpLc9rOdzV8+1eUZrjySBqlliKYDKe8SvC9tgDA5sma3THoz7n1zHVwNoF+uw
         8hE4kdCrer9ggU9FFZ31gfiDaKkkeH+hL6crXSdColy15L8GT/z7wxR98KGTstKBcbHF
         BtpBP/QqJrnmpfEIQTIh/xLLuY1J6JqtB9UpJdvau7hlR5cQUwrzgvW+LC200VfYyyhC
         UmB9nKRX6U9xdyOXzo0wCu/yG2lT8SoIgPHUF8pg7dX8LqsKwe+OWlVLHadMhFh/5ryj
         twjQ==
X-Gm-Message-State: AOAM532cMOy03O1ZRAp+KlcwRBWTBQIh2500NFrDVUBDRe68ZFQsRdFz
        GV3s0Hj15bMGcz2jhARYRE5WnLWFsgQiEw==
X-Google-Smtp-Source: ABdhPJw8V0hN09vn6qMlXU43NAuiryNHrDsiEFWKhIEDdVIwr2He8RTDBr87CnFsvLyQEVznm+NUwQ==
X-Received: by 2002:a63:c20f:: with SMTP id b15mr18599734pgd.230.1605054036660;
        Tue, 10 Nov 2020 16:20:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y129sm127683pgy.84.2020.11.10.16.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 16:20:35 -0800 (PST)
Date:   Tue, 10 Nov 2020 16:20:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, corbet@lwn.net,
        gregkh@linuxfoundation.org, peterz@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <202011101619.341C9C7E64@keescook>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <20201110210316.GO17076@casper.infradead.org>
 <11b5153f-e092-d1c9-deb1-e81a171bb866@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b5153f-e092-d1c9-deb1-e81a171bb866@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 03:58:48PM -0700, Shuah Khan wrote:
> Yes we have some instances where unsigned is being used. I considered
> going to unsigned. Changing the API to unsigned has other ramifications
> and cascading changes to current atomic_t usages that are up counters.

As in, existing callers expect the "read" value to be int?

-- 
Kees Cook
