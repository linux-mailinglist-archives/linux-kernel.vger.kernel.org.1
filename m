Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39141B3929
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 09:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgDVHjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 03:39:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46499 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgDVHjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:39:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id f18so1151656lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zGscgFhHY8NA5eLH18mLgSeKi3UH/pOfcnI3ew9ER3A=;
        b=LTdBPo+UXdRaITqG5Ufpr8qWbGVNho+r5Cs04xRFFoF44M5ro4YdPEvumdv29bwCng
         HrmOLSsOpSkEJASvXC5L/G/La7JgPxs0LI5ZuEScomJOET2GGLH/7nzTSY+ceIXcR7xe
         l3IKzgh6nLnJV8OrZ48W+bdCNBMqtX7ebDy/qsZdeFuSkO5qBjkh4dYqF2Z8iLCmVLi4
         idgGS0Q2NKpganmNhd5yj9w0p41QNvMg+voAgFJmlelA4d2rrq35bNXDdyyleiJ4qfCp
         0q8ictgrf5GdL/rNEqq+OGqnSgKlmryXzc9WcCS02N7LR6Da3I2GYOjjbpiAJE1t4/+v
         0cMw==
X-Gm-Message-State: AGi0PuauoMeUwsiYfNNIBo7p6OkCr5XFDI+uvSfCozIpdMpnoaCbxIL5
        NOpXVbg2ofGocyN+lY1QG60=
X-Google-Smtp-Source: APiQypIWNRK6TM2V8ljdse8PMIAgIHZiWJMGIEyTkzRsZ5cMuTWF0RbKwMKM5IuTT4LyTzJJQN8rUA==
X-Received: by 2002:a2e:b8c1:: with SMTP id s1mr16023319ljp.0.1587541160045;
        Wed, 22 Apr 2020 00:39:20 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id g6sm1382667ljj.78.2020.04.22.00.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 00:39:19 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jR9yg-0003oZ-88; Wed, 22 Apr 2020 09:39:26 +0200
Date:   Wed, 22 Apr 2020 09:39:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     zenyu@tuta.io
Cc:     Johan <johan@kernel.org>, Elder <elder@kernel.org>,
        Gregkh <gregkh@linuxfoundation.org>,
        Greybus Dev <greybus-dev@lists.linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] greybus: fix typos in GREYBUS/GREYBUS_ES2 help text
Message-ID: <20200422073926.GI18608@localhost>
References: <M4O-2uM----2@tuta.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <M4O-2uM----2@tuta.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 10:55:22AM +0200, zenyu@tuta.io wrote:
> From: Zenyu Sy <zenyu@tuta.io>
> 
> Fix typos ("an" -> "a", "chose" -> "choose") in Kconfig
> 
> Signed-off-by: Zenyu Sy <zenyu@tuta.io>

This patch is white-space damaged and does not apply. Please fix and
verify your setup by mailing the patch to yourself and try to apply it
(and/or run checkpatch.pl on it).

And since this one supersedes your first patch you should have added a
version number to the subject line ("[PATCH v2]") and a short changelog
below the --- line.

The spelling fixes look good otherwise.

Thanks,
Johan
