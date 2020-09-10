Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C1264E87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 21:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgIJTSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgIJTQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:16:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43B8C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:16:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so5232952pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WTUCcqNRIoS33fWn/0Jo09nwI98p4mA4fR3hKii5V3g=;
        b=GP5wEXl8UxhK+wcw6bvQ8Am/4d+n1zlegGhFVlx19po9y+fxYln7mlXhhNrTC3K8aT
         1Kpc4olKCW9bvLkkS8hjjHSD9uwEbHfJkuYPnUbjnGPZbnVQ6u58EWyooJkMwgGX8n7h
         EsOtvSQQsa/3CRyuEbiS3dBB8W0i4oB9WOQOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WTUCcqNRIoS33fWn/0Jo09nwI98p4mA4fR3hKii5V3g=;
        b=BuIybvEtcFLgzFlYZRJktUrZ9jFql8AraIfzlmfSL7WByTDFI4FoLr0uVJXADcJGi1
         j+SVEYwY4ZgcXIQy9zRNcvJv3dtj3eNiQkcziR8QykGZ1oMI0aoHso7WYsjSHBLsZiZu
         f6hO6Q1zydKb8G5Dx9wSlFsWkf4wDoNLKJxDtMhAy2CtkR1d2y/KxfhfKbsFyijfVwcu
         +C0H8KNpxwqaVpMTWbzTqaJclWgZAFpGtTEi4pvxKbS0LmEnDe9/BAiZ5IiSKQ0NghGx
         2N2MqZZ9dpWXyPC8lRfDRAzAn7cbFgl3QYh4GrcveVQ++nFiPsTPktx25Bii5Yoqlmuq
         s86Q==
X-Gm-Message-State: AOAM533B88tzoxeldlZdWVslMB3HoIwJnx/XJchxVvQLmAycuHz8UFUq
        wa5hROxaPX+hJ9gD+HOMqYYuAuipn/vrMOMz
X-Google-Smtp-Source: ABdhPJxB4PeK4jJudm2ddbNQtmc+Mb5hPIfiGDzHr6/1df0l5PgqUj2b0a/gbvPaj2mmUYK8b9fLJQ==
X-Received: by 2002:a17:902:8f88:b029:d0:cbe1:e719 with SMTP id z8-20020a1709028f88b02900d0cbe1e719mr7176681plo.39.1599765417304;
        Thu, 10 Sep 2020 12:16:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y126sm6981346pfy.138.2020.09.10.12.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:16:56 -0700 (PDT)
Date:   Thu, 10 Sep 2020 12:16:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Elena Petrova <lenaptr@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.h: drop in_ubsan field when UBSAN is in trap mode
Message-ID: <202009101216.1F173BD87D@keescook>
References: <20200910134802.3160311-1-lenaptr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910134802.3160311-1-lenaptr@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 02:48:02PM +0100, Elena Petrova wrote:
> in_ubsan field of task_struct is only used in lib/ubsan.c, which in its
> turn is used only `ifneq ($(CONFIG_UBSAN_TRAP),y)`.
> 
> Removing unnecessary field from a task_struct will help preserve the
> ABI between vanilla and CONFIG_UBSAN_TRAP'ed kernels. In particular,
> this will help enabling bounds sanitizer transparently for Android's
> GKI.
> 
> Signed-off-by: Elena Petrova <lenaptr@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

(This should be CCed to akpm who has been taking most of the ubsan
patches lately.)

-- 
Kees Cook
