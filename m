Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7158204A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 09:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbgFWHDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 03:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbgFWHDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:03:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D34C061573;
        Tue, 23 Jun 2020 00:03:12 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so9462481pgm.0;
        Tue, 23 Jun 2020 00:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4JVWCz8+lqtSop9dl2ZAnWPRN6EuY7Bv8qrsUVE3nXI=;
        b=eOert1F3W3A+fuUjzfaUw/OvDWW+QrwyruMv33b8OO6vVCo45o56Wqe2hKdpObJ6/k
         0Mya8f7dxVC+Y0xaw5ty1qtaZjKs2W39IhD+HUmDbrHFGncL5wGhXqBOZCnceQNDqrm+
         AdhnJF6heFeUcHGTdQPDrNlERwOJMkQ83wFl4QG2TRSnfaHzqeQ+WvSUwDNZnoCjNH4j
         IuH/Z3nqf8i5oHVwiAJixTbpYGr2nYXL5YUUQeOEE+1sguNP8TaLNDukiImeazNAMuyo
         CKL8TfrnChJdSJRDkC+Yk36DdtMWk+gCaA+CqIKtq68CuYvUiG1gxeP0pk+JkV4PsREL
         zMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4JVWCz8+lqtSop9dl2ZAnWPRN6EuY7Bv8qrsUVE3nXI=;
        b=bdvgGHRvsEQe2KKudQ9N8e86zBf1Kyj+Mzp0tCa7rP/YUFl50PvBvLRh/CQfFmLUi0
         bDwpX1YRNdJYd4F+pnbxgzpJTkO8lqChimYy/2bJwWvvuxSSns+Coe4kgmUvQnIfjQdr
         L9gBk9236bcsw65zcbFUUAd+tTORJRwKY42cjlEUJVH7+wl7mR1m27rNI1NxDr83X2MX
         l8OeCOROaNhRXFKqykfMr0y5M+MLcMWMrNOx6LSwn0UzXIiZPPSTcvLk0HaPF0l/6xaP
         u0pilt1jhgE9T2oQuY0uwKVPJdPy/SKbrpj0bSFXuCX85AwCmwXqirtRwc13A1OK3S7k
         RegA==
X-Gm-Message-State: AOAM5339cgXphQia6WptCgfMhIfvKcv1c8yy3fHRJoN2YQr6TUgg2STK
        yDZGWctYF7yNWoXvelsJ1cU=
X-Google-Smtp-Source: ABdhPJxwNxkZOf7Lk7xd3jy8Z+Qwdj4VK/Om3PshkykoWiSM8D32CqOWsfyLOHBjXexj0MN1jzYFoQ==
X-Received: by 2002:a63:7707:: with SMTP id s7mr15672418pgc.295.1592895791467;
        Tue, 23 Jun 2020 00:03:11 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id z144sm16857370pfc.195.2020.06.23.00.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 00:03:09 -0700 (PDT)
Date:   Tue, 23 Jun 2020 00:03:08 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wade Mealing <wmealing@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] Revert "zram: convert remaining CLASS_ATTR() to
 CLASS_ATTR_RO()"
Message-ID: <20200623070308.GA186116@google.com>
References: <20200617103412.GA2027053@kroah.com>
 <20200617114946.GA2131650@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617114946.GA2131650@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:49:46PM +0200, Greg Kroah-Hartman wrote:
> From: Wade Mealing <wmealing@redhat.com>
> 
> Turns out that the permissions for 0400 really are what we want here,
> otherwise any user can read from this file.
> 
> [fixed formatting, added changelog, and made attribute static - gregkh]
> 
> Reported-by: Wade Mealing <wmealing@redhat.com>
> Cc: stable <stable@vger.kernel.org>
> Fixes: f40609d1591f ("zram: convert remaining CLASS_ATTR() to CLASS_ATTR_RO()")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1847832
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Minchan Kim <minchan@kernel.org>
