Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171A42DBAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 07:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgLPGBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 01:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgLPGBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 01:01:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DE1C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 22:00:29 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id g20so31054249ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 22:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FR5X88fegf8w0UuIVApL8BG0Iy1zSrKwV+m5ej9rErQ=;
        b=pcUOAL9L6nMIhGkoITjlm4bVCQUpzXo7PNb1cRp7pA84vYQExjZwfSexq7/qB9Hn0F
         72jjyjqle9z+ZW2N3Dinf6lE+CMRDpM5rnxpzdJP9dMtdsw7S5afJU+CaKBFFNLYNpaf
         vkMfasE7jzxBEYsyhQGFJ1ZbflOuNM2t1stDkjq9QNJtqZGc2ePFknhaFgwo4INGiHRQ
         yvZLgkYGYW6xC+pgDSwms11sPk99vDugmU8mkJi4FF6sUiLDS1aq86wCjmNpkjqwS1BR
         P7Kosamib8+LczNIrreG/JEBhL9EWBOzEE87zN9r6v7NEv0eLhGKBzzCu7D3WWAum/Zx
         LWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FR5X88fegf8w0UuIVApL8BG0Iy1zSrKwV+m5ej9rErQ=;
        b=rPlt0ZWpkHV2Xy6xE91LjwapyXk8N2ZEHk5PodpUY0qxGMmmMnJ++gYA+VZghaghal
         I5DdyoUYPZMy/vrUAFmzRMkZ1wvdPFJx5WaDjyFqatBgjUEw7NVxLSBR62PH9IOqNW7g
         EKMHnKTs8PVffrzaoUVDuvdA6meOzY7EpQXewCMMOhk+xcwnmOqEg1XssfrPEqiS82L3
         YWj4ect1D05URvqffw4uBkS6p5qqOm3Sj9ke15RGP4ziGyyFk0zipyx+1IQvNcFvrC2P
         r2Rr9Us12t/cXJfv0QBSMMonkWv4bsLbUiCIJ2CAD7i7cF8d9EX/sr+6dnZQoW1YX6k3
         yxdQ==
X-Gm-Message-State: AOAM530+ROARQdMuhWSrPyHlHBRJMzMYpRAXpCn08ehNO6zdfZxH5OuL
        KsEzzWfXUfYrqn6Cb746ryDwIe+nI635LtRKS2B8nUnJTjA=
X-Google-Smtp-Source: ABdhPJwXBatXsBNnCwAYc+YWicFXF7XTdcX/WoVJv/PCGD8ozlSDeJQLyeOyEI3ZubEb19fMhGTkOXS5c7cwa12GLEE=
X-Received: by 2002:a17:906:a3c7:: with SMTP id ca7mr30729536ejb.523.1608098428423;
 Tue, 15 Dec 2020 22:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20201214134506.4831-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201214134506.4831-1-zhengyongjun3@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Dec 2020 22:00:17 -0800
Message-ID: <CAPcyv4hKOk-00uc876m_UZdUEKNgdgPeew9LWSTT6ksgXn8Mqg@mail.gmail.com>
Subject: Re: [PATCH -next] dax: pmem: convert comma to semicolon
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 5:45 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Thanks, applied.
