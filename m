Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE0F2A782F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgKEHpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgKEHpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:45:16 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96DFC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 23:45:15 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id o11so826672ioo.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 23:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gw4vmbm6+5GWDF0o5XQrpTP9RNmsK2gI8aXamFks1M4=;
        b=OKOUfNxNRVhP5T2+TMkFnJ/zGX49hm358GxrWFrjQrThN468dkcuzvhnyvRT5PwMIj
         Y+elqvzOdUbxaF6z6yzus1OIOM1iZ+7acUoDFVo63iCxVriRfze8i+CPCgtLy3Q/g1qM
         EihToU9qbzTfLVJltYXNSZkUWBxxe8erOo4CXWg0SU20A/+zY3GvPx7+XREeZEmvm4Sv
         Z/pYs0ivYeeqs4cdIDaiK9DpjWASjt6lqZkvGlg0NdiWzma+zTnlM1GPw2V4WbE2HVZA
         IIzX/6wKxO5iKlBpccg2uwGiYlSWsGTfgPxSlzR8YA+8j4b5F60TZ53JNRRexxgwnft3
         /+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gw4vmbm6+5GWDF0o5XQrpTP9RNmsK2gI8aXamFks1M4=;
        b=sdooDooHbWrJt4MX5R7KRY27uWY+Xv3FJW6v7uH1eQ8/av2sYeGmpqxPs6xaSCyqlz
         Qk5tXqfdUZI/ccoRowUP/AZy5Ts9MQegz1T2N/ezi2HCHY5dAsRRKYIU23g3HoQQ38/O
         HwVzLbKy70ixYqFSSdXYOfcvvP9q917ft0j3u710qsSZOyuoYgV0oMS2sO6RBeC2yetA
         8jJq5TOCoXK1I0HwpGokzUvU9/WWQ6GYR37xL4o0BEK9vOKskY/ajYnEwxUtjmv3dGt9
         oONZlnh2+ZXiQTJfrhIZvPQkK1zZ8HPZwIIHXjy47fMj7oM6rplXE53WQAv03AT/cfk8
         RTOw==
X-Gm-Message-State: AOAM532qVzEQMxqXBzcSm6WAJdBkcqsgYcDiRPo68EpgRckgI2jXadz/
        TZkA0pxW6YDSii+lRKWrTEe97e2HM/ySgT0+4fjRU2GkS9kx3dzP
X-Google-Smtp-Source: ABdhPJyDZ5pxgd2Wi2zKaLXYJKjVIIA0f7RlOZgGQat9zzZ2HsLcRi/sUQBYL5mE7CdjUT6xtNJyYJyea0xlUAPCc7Q=
X-Received: by 2002:a02:1783:: with SMTP id 125mr1072347jah.121.1604562315167;
 Wed, 04 Nov 2020 23:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20201105174549.614c2de4@canb.auug.org.au> <20201105070311.GU4879@kernel.org>
 <CAATStaMD=w+onf==L-=MQ7suJf6EaNoup5o8yW-TEbfajkbdaQ@mail.gmail.com>
In-Reply-To: <CAATStaMD=w+onf==L-=MQ7suJf6EaNoup5o8yW-TEbfajkbdaQ@mail.gmail.com>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Thu, 5 Nov 2020 18:45:04 +1100
Message-ID: <CAATStaMEn_CSfvc=JTawGhL8yt3L0cci8XK9ru+F6RGzRcYJ7A@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SNIPPED

> >
> > Looks like left column became too wide, so rather than shift the right
> > column to the right, I'd suggest to drop underscores in Speculation*.
>
> Hm. That makes it inconsistent with Speculation_Store_Bypass. I guess
> it's the lesser of two evils.

Oh, do you mean renaming the existing Speculation_Store_Bypass? I
thought that was a big no-no for the kernel?
