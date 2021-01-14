Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60872F6D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbhANVid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbhANViR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:38:17 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE031C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:37:36 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b26so10174779lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DPKrR/GXMZaqhSQSj3/DyujMQIDa+CTPA7V3yQWR0s=;
        b=gkrpBnHRYvioEZZaxpsKWlQ8fdN1oyyP5iwQ03kPk9IyMVAtQ+Cqf/UoGz76OCEaU6
         baj0lo/iBJVj8+SgxvkUI02Q9wTB6+SZt/TD8XjMbPyvEOEeDgFOV66vqKGPdUAG3aKW
         KkzkGv69tCMPo7VMSnpsDBBymGDnt8kwOZF00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DPKrR/GXMZaqhSQSj3/DyujMQIDa+CTPA7V3yQWR0s=;
        b=A088VIXTYL7Dhz/IUelI9bFz4Ui4HGsn4beXgDra4dFX8ouZNMIutYHMD78jbHO0dr
         Qi4oAUL0qGt4mdJI7y0+MiuY6UupIfveTrbDqDoWKnMMadsBLw1Zc9yxF9vLOQtHLzYO
         9te+LT/0c0QaBd2H5YcXBsIGTVVtEQPUPNRtiuNHi5RXEZDdgL4/c4dn+JCSdtBQRKpL
         i+SMoLqWMYDn8CngY7syAnL3Iur9ckFeTBRhZ9QPC/jckbBW/DezvuX0isL7Afny6j9Q
         o7aZYyt3xC8Qt4BT7OFCkCY1CNl4p09Dw2PfuX3caEQotCjvdBvN1AmBijuWe52fy6uS
         038Q==
X-Gm-Message-State: AOAM531Aqs7SZ3ZQoC3U07XDWEBgE2c9C33XnS7XL7DOiqgxTOqgPJA0
        Hp1bIcAC5oVL8EamHPGpOvzQiHBplCaqjw==
X-Google-Smtp-Source: ABdhPJzRYSnw1z2r8OgxW9+Q609x10q1LNHg7Ja75elRWPFHZSuJaky4wNE1HNCgR9wl+DhuFQhtJw==
X-Received: by 2002:a05:6512:a8b:: with SMTP id m11mr2332107lfu.112.1610660254968;
        Thu, 14 Jan 2021 13:37:34 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id m26sm576585ljj.134.2021.01.14.13.37.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 13:37:34 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id y22so8119991ljn.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:37:33 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr3930824ljj.465.1610660253546;
 Thu, 14 Jan 2021 13:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20210114200551.208209-1-kuba@kernel.org>
In-Reply-To: <20210114200551.208209-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jan 2021 13:37:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjWP_7VU8Pi6A-88-1X7F_fs+2qoGf6qjkVOUnFQd3CDw@mail.gmail.com>
Message-ID: <CAHk-=wjWP_7VU8Pi6A-88-1X7F_fs+2qoGf6qjkVOUnFQd3CDw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.11-rc4
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 12:05 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Current release - regressions:
>  ...
> Current release - always broken:

So I understand what you mean, but it does sound odd with that
"Current release - always broken" thing not being a regression. The
"always broken" makes it sound like it's some old broken code that has
never worked, which it clearly isn't.

Maybe rephrase it as "new code bugs" or something? You've done that
before ("bugs in new features").

I left it alone in the merge message, since we've had that pattern of
speech before, but for some reason I reacted to it this time.

          Linus
