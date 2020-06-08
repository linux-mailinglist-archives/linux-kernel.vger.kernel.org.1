Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943691F140F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 09:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgFHH6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 03:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgFHH6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:58:05 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8623DC08C5C4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 00:58:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so17194688ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FnYXOarcP1xioN7l4ot1AhdtG4JNoUpeWg/XNLd3npE=;
        b=f5yQijiB7OowIorlImy3UsKTTNlGwNW8asfpmQeSJSpDOgsCQfZzpWPG2Sz7dqu2Wn
         DlCOiXMwFuIkrEDfutgWaW/ibdyNhBIoR9RfMMurf+TsX8JZxCQ7Md8H42cCOXPQkDlF
         dYoMSvAjAMlln3QQxq8PirkAWlSDGhjysCJ6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FnYXOarcP1xioN7l4ot1AhdtG4JNoUpeWg/XNLd3npE=;
        b=MjyOmXlIO+JhQWbUJq7ixTGQAkluQZIlR+LIxktdjf3w4W5QlwQAsJMI5EG6ybP+e6
         h9WayOCiCZ741txHWqvfBJimiAxrJYis2pPG/gy+700cp5LJQ71ZEbIIeC2joPuVbvIJ
         cnLhIqcdL/5h3CkNfYeDj2jdAFAE9CG6RP9yn+nhaZ/qoJqxSAv55XLMIPf2lEys8zyS
         5Fd7KtsqddkzTCOR6/ttGZdxbdAN6w3RVuToF0NzqWMuse2OcnV/GM9cuUzK7tuFqzhN
         zA7QzxDCfY8qemlbyqmoAd6aUQhphwxAyGNg4Tn23wKUGH1Ws451nuJSQi3N2AJ4kR9b
         4PbA==
X-Gm-Message-State: AOAM533LLXAU0qLRikIn86x3IuBvkYTdn83XqcvsC9MDsB4fBpCziIWw
        Qapw6K0JZtdwMZ5uDLDguWWskg/QsV5e5bgAQvIU2Q==
X-Google-Smtp-Source: ABdhPJyCnIgBCEDCoNBHqGYQYEaBdJkbGGZWn1i7zhoiyk6/vMeI0WdL99LC26+sCX/39e5gIGKyvz/Q0eJ828xDpGI=
X-Received: by 2002:a17:906:1947:: with SMTP id b7mr19043161eje.320.1591603082179;
 Mon, 08 Jun 2020 00:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200607090406.129012-1-her0gyugyu@gmail.com>
In-Reply-To: <20200607090406.129012-1-her0gyugyu@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 8 Jun 2020 09:57:51 +0200
Message-ID: <CAJfpegtQ03eDpK-=0v18hat9Dbmt779YoHuBQ=dt7n=ariZqeA@mail.gmail.com>
Subject: Re: [PATCH] overlay: remove not necessary lock check.
To:     youngjun <her0gyugyu@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 7, 2020 at 11:04 AM youngjun <her0gyugyu@gmail.com> wrote:
>
> dir is always locked until "out_unlock" label.
> So lock check is not needed.

Thanks, applied.

Miklos
