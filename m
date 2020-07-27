Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E197722F6DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 19:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbgG0Rlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 13:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgG0Rlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:41:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280F2C061794;
        Mon, 27 Jul 2020 10:41:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lw1so1507338pjb.1;
        Mon, 27 Jul 2020 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1TfTR8Lp7hRKQ+lCxjn1lE5hq4Qzl/G7eGSS/NXpthA=;
        b=Cq6woHmUEFsyeHVigdpNgaWCeD86WWgw582JKS8rCuPZybUNqZht+GutR4QWkIv2Rj
         9YF0xezN/AKwW3gE7MsWbAdbBZWZqmsUTVQSWSxzE645sU1PlnnFcMrZUDSuCQh3oVaz
         YN7MtpJ1T+LTcenKvw8P7BhQ9kwwN0t6NnrOs0ph5RxPS+XY3I/mtt0HAUbR5a6K08XD
         GRUQaxnNqm7BNdiun9d7MkxmLN1w2m6YVitUFpuxMmiRSrsUsNquGHotkyIIF8x1mQfM
         1xv0j1DbNWQbwg4ML0p2K8SN7KufMNTaCpj0MmLmDOY5FOvC9ZsMd6wI113SGHMx2WZp
         rXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1TfTR8Lp7hRKQ+lCxjn1lE5hq4Qzl/G7eGSS/NXpthA=;
        b=Mrt6hNZExeloid8uyPP5qNTJ13fwW+r5Uprmpe67415uS7CKNRqpcb4qCIR3wqlD6+
         QfIyU6rm2RalyI9PQqCoVE768QBjVP6cCDFGOa4bSx0xgie+AMRfQlUjBwYoShBiwjKJ
         4tnZMTwLzIQLX/zJDQrq2l63ku5ssX99VWgGDpkv2hyui/DR7xjpwuYmQDK389qsw0Cy
         TWNq5i/9j7YnhIRW3o8HCStseCQlT47QH8SIHv04Cq/uibeiaJdjKrog4DKqJuj9l7l2
         cEmNulG3wJkzaQJtn+YzY+pb7b3ISCnTl9ZOjVl83sM5ivsYu0BcFstOS/qfcLk0kEtn
         KMWQ==
X-Gm-Message-State: AOAM5337+KLfbnJDi3e7audoled2e/XK6xeORDl3bCK8ffzqumixGP/V
        B8nD4vh9nLKH5Jp/3q5eQWc=
X-Google-Smtp-Source: ABdhPJw3h5ONincj8TGVAAY/7gRJt2JrJiVZpSVpdEaIygpNKh6GppIm6ej3Djgn6lbXyudPGEncFg==
X-Received: by 2002:a17:90b:2083:: with SMTP id hb3mr381357pjb.234.1595871696690;
        Mon, 27 Jul 2020 10:41:36 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id s194sm5470283pfc.187.2020.07.27.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 10:41:36 -0700 (PDT)
Date:   Mon, 27 Jul 2020 23:10:12 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] ata: use generic power management
Message-ID: <20200727174012.GA696265@gmail.com>
References: <20200727173923.694872-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727173923.694872-1-vaibhavgupta40@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is compile-tested only.

Thanks
Vaibhav Gupta
