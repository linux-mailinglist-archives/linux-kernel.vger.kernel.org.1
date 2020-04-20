Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39931B0C38
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgDTNEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 09:04:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46199 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725944AbgDTNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587387886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W/bxTTX2WEiUDHSLV77/6UHjct+uk1657fsz3qpCp+I=;
        b=YqIObYa8jCUCz0kAlQD5BKxKbBzWWt1zXjuictp2R3wvGXtjp7b1lrFmV/henszxZZd2Gj
        kdpenHcZRMdRxug380shV5YzkOjugVL6FrugKY79YMLxcoSgnbyB1oej5mVh7UMHCs+Hk9
        zFSnk5LrzPbUeiwj9h+IOUdUhgt1nQ0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-hLQd3EsgNh-5zB5IGFgCag-1; Mon, 20 Apr 2020 09:04:43 -0400
X-MC-Unique: hLQd3EsgNh-5zB5IGFgCag-1
Received: by mail-oo1-f69.google.com with SMTP id p23so1870418ook.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/bxTTX2WEiUDHSLV77/6UHjct+uk1657fsz3qpCp+I=;
        b=aIZqDR/kCdEZ7PMMJ8/h/Obd2ZN0jSRqrDFahh6Kg+rCSW6++wOWPD9/QuA7y5RlWY
         7FVY6yuKjqgq7p+Wq1BQuRkWQv3ZM6tVuDm4F3LkdO0q/j0Q5MmZsTpD14LnQPC4ZEzd
         ZtnnrmyxPJ3EwJmnlCqkzuBmbUonV/VC7VI/6XFBVp2nGjrg8ThPHWht1S8k4+w3jYYL
         0EI78K3NvrVeALA3g4fJu9sHZ3pW9yM8+IjKt2UkwOnUk/sAWVzuvZpVVXy1wH5x971u
         6t2xVm9ABKa8XC868O+hQVOLUBlBRO3hEvU5kTOc3pdevYkIULvkdZMxRs2opwnHP5hz
         GkUQ==
X-Gm-Message-State: AGi0PubNgM5w3x0f7VkLnNgHhS15EPgn/UrJ+AdtFVnzq8vqURojNYfT
        N/4zQX7bZwIdyZLc4/WWwBj8+bTmUv1HcH/gUubBWdCyGHLWmGIL1Q9ZWXIHrF6iX32Yj84YB9T
        l8WB32a5vM9ot27sof02kg7jVo8stSSZ5hkrErHjM
X-Received: by 2002:aca:88d:: with SMTP id 135mr9971523oii.10.1587387883021;
        Mon, 20 Apr 2020 06:04:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypLY7P4yV5E3/wHnumRqm5PZKROtZDJ6lfZUbx8EURZu+U+ZcCM/EEpfnJ9UL6QjsmXOxs19CnraHACJqSY6K+E=
X-Received: by 2002:aca:88d:: with SMTP id 135mr9971505oii.10.1587387882792;
 Mon, 20 Apr 2020 06:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <1587361410-83560-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <7b95f2ac1e65635dcb160ca20e798d95b7503e49.camel@hammerspace.com>
 <20200420125141.18002-1-agruenba@redhat.com> <52a445020247f4dbe810ce757e48cd563a69c4ce.camel@hammerspace.com>
In-Reply-To: <52a445020247f4dbe810ce757e48cd563a69c4ce.camel@hammerspace.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 20 Apr 2020 15:04:31 +0200
Message-ID: <CAHc6FU411Eoo_E=aQiR=Vk2Tx6XCZEuiz25NykWY+dd5wKrszg@mail.gmail.com>
Subject: Re: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "akpm@osdl.org" <akpm@osdl.org>,
        "xiyuyang19@fudan.edu.cn" <xiyuyang19@fudan.edu.cn>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "okir@suse.de" <okir@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanxin.ctf@gmail.com" <tanxin.ctf@gmail.com>,
        "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 2:59 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> Well, that should Oops when either IS_ERR(acl) or IS_ERR(dfacl)
> triggers, shouldn't it?

Yes, checks missings. But you get the idea.

Thanks,
Andreas

