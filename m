Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721B729F44C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 19:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgJ2Sxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJ2Sxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 14:53:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6EAC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:53:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m20so4267115ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZe3AQjrpqH5xb0HFY+F5bJm7+6FpbLNI7yCa2PA1xk=;
        b=fYo/tT9VWNa6txrV/eT6Rp1NB/LxKNnV4XnN6GV7T88v+FpbFKhTl7p/DKDaIdTmgz
         YLEO1C38eIj4PXcYJWKEGnv3IeNHR3W/Yfetn/B3URQJYD0IR+N91NBXn03sGmrzKmHa
         let6OzGitZcVIkBN3Eke79gVjw3MJlwWvhlGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZe3AQjrpqH5xb0HFY+F5bJm7+6FpbLNI7yCa2PA1xk=;
        b=JLZIcC3iTnUn/yvnXJ++cTgRvv5V6VAgmfqmIF/PAmJAMOW3uQLaqSC9+OqiF6r6aS
         M8CeUbo8bMp+0WdE6n8OVsf9rmSQ92iT3sOsZsr9eg9Sll1yR3V26vOOWpKjeCrO3cdh
         FaS6JDBCbF2iKrlZA63AWPcTVjVD+rpaQN7g8769mGdoWAnS7IxAMZz3tSINnb2ms+Tn
         ZNMFvjqB8AaIHKRrF1hp0C78PDrKizfdFTab3RQXNLP+hln/ycHf/6nMND2VPdg9P5Vf
         /JiEKDBJ8rDOAyO68Yak7v4a5cWyBiRyUQt4PHmEp4f4HXkSV0/LiknYw24uZY83rC24
         Pj+A==
X-Gm-Message-State: AOAM531q6fDFBEhXdOvxzcwMFTKTD4TGTrvE6v18I8vX+f/af/7REpGo
        4eLRi7+eW/PWy2hHaF2Zrs+y2XN/fQ1abQ==
X-Google-Smtp-Source: ABdhPJzcWjCvAgPFjVzw1bmp3kW7r6/tzCvS3hXFGL1xybfSx7+JhpACJxWZK9zdidcUz5LyEP6HRw==
X-Received: by 2002:a2e:9652:: with SMTP id z18mr2430042ljh.410.1603997617803;
        Thu, 29 Oct 2020 11:53:37 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 76sm363051lfk.157.2020.10.29.11.53.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 11:53:37 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id m20so4267028ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:53:36 -0700 (PDT)
X-Received: by 2002:a2e:868b:: with SMTP id l11mr2386293lji.102.1603997616544;
 Thu, 29 Oct 2020 11:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201029184123.GA2920455@nvidia.com>
In-Reply-To: <20201029184123.GA2920455@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Oct 2020 11:53:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8K7tn0Y_ne4nYTEQigZKE-foAOnjkYzTTRh0ruMKTyw@mail.gmail.com>
Message-ID: <CAHk-=wg8K7tn0Y_ne4nYTEQigZKE-foAOnjkYzTTRh0ruMKTyw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:41 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> Three notable merge window regressions that didn't get caught/fixed in
> time for rc1:

Three .. and then you list five things ;)

                Linus
