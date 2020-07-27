Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6C22ED47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 15:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgG0N21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 09:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgG0N20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:28:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB91FC0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:28:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i19so8990756lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOqZtq8jjYGsRrVE9SfOle2aGRnGjTTajFWgsMLd7gI=;
        b=oS9RvDUMQeGfwmgdSCWGfV1B2GIKKEJhFrjFeWhGkG7qgakjvxs6REU2MKlHBProdS
         GpwXKK2siUcskNGjWF9vvF446AH5dhXkieeBzX7OWsCEldIbv/E/wf6CZhZvATIO4kf8
         v+OB+xQh1Lyp0Z3yfqCDfY+GEjDXZNi/9YE5syOKWfW0zGSg8alkKPTN+kMFo+Tk7ulV
         wGCknvO0pU/wZ8+bKNO3QsxnyOMmCWONpMApvL9VF38FQVF2oVRgVju/UjVVdBcbTClO
         l6r5jtmsOOv3dCqM2ztlbdzO/gTE2U3Ij37aZoR2DojjI7YkOttQwep4ycWE0dsKTUVK
         Cn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOqZtq8jjYGsRrVE9SfOle2aGRnGjTTajFWgsMLd7gI=;
        b=KcGfpac0ChCV9sot8XNhfvjRnz8KsuIWaDjG2iczPHXDSmQFwZhuOdDt1TJkDBHzL9
         pmA36EfmCWesfqyKPiHn2p7AJLeLtwwhtIaVjCY5OmoiCE8yhpiorpJxBnCTBVe618c5
         3f15d0Z4y13PpVdjOXx9kkTa7xg+1AJYRWW8FebON6dl503sgTKYVnLQ3xO9Zx9O7w0U
         d1yJ2E2zGJbXaCD81xE2IBjKQ9YSZYetXNWRUp3VxMJXkmh3drXujFpbOf76A3NKBJNz
         qCKuJ9FL3D00F6mpBb4kW3v1O9xi5EazsMzegP18FpIkHZa0Frc4Xpemjm5J05WFW4mR
         C2HA==
X-Gm-Message-State: AOAM531pb4uYpBgHKgiMnqNYq5ijAKoAObTmfXisFXjAcJ6DIVc1wS0T
        YVxA0OjjoFS8P6TVlxBNECZZsQtlw92AxqeWQW6pEg==
X-Google-Smtp-Source: ABdhPJxGHOXZCG9AsImtYwpDzkDpPQ4nkXAG0kareKMahSYOQsdz7xhKFMJbEbPGn/7D27VIvWTBsU2LlctndTriyKY=
X-Received: by 2002:a19:1c6:: with SMTP id 189mr11675726lfb.158.1595856503472;
 Mon, 27 Jul 2020 06:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200727134433.1c4ea34e@canb.auug.org.au> <20200727052224.GA933@lst.de>
In-Reply-To: <20200727052224.GA933@lst.de>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Mon, 27 Jul 2020 09:28:12 -0400
Message-ID: <CALWDO_W5mY9_KJwWikCtAZufTqSFnn238C7cPy34RQoqASpxhQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same here, thanks for the fix!


On Mon, Jul 27, 2020 at 1:22 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The fixup looks good to me, thanks.
