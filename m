Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8D22FE5AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbhAUI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:59:49 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44644 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbhAUI7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:59:02 -0500
Received: by mail-ed1-f54.google.com with SMTP id c2so1257677edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8WAyxlQW+qRjKuEj3EfyxMAC83cU2qodCZupcFO3MBY=;
        b=YN4w3FJvesPZITH3JfltzliK5bvi0JrIYVedoTL8TCXwr4kLkNA4KQa+MYdp9v96e4
         S7noCyjy4lLL4q+3l/6oGFuxR7mZ9HNmd5EPfXfw1ra6jBLwb1Syq83YUQLGao0oc95y
         1xlFxy3uvkJavAA2j+YYUXxbnqPI3y1btYZxGZj9DbW9pUIicbcpYJM4qrTMTW6XX2wE
         eIKH6wiY7AUfUzlptbFJmc7BZxBr4KtfVGkUWlOhZ4ReXu4tyqTYXThwHfsMaKuexRUE
         n0shEFOo1O90rPHieRi9X9GqZvkuiKrnDMf681+OlIN8Z7nZSrrIosnUHx+2LBMEcKer
         G26g==
X-Gm-Message-State: AOAM531JkI2EiVjgMHS8a+pTZ8wAC5IfzcMsrlvoh1DlTGYpSclqAfWP
        acgDK8/OodxJOizxxAn3i9o=
X-Google-Smtp-Source: ABdhPJxNNXLYEzY893lvshXebzybuFMXDXLT8vvb8jH/hRXBM/4SmioPS/bJ54tM6GW2K1pGZYLAYQ==
X-Received: by 2002:aa7:d803:: with SMTP id v3mr10038977edq.153.1611219500351;
        Thu, 21 Jan 2021 00:58:20 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id b26sm2360760edy.57.2021.01.21.00.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 00:58:19 -0800 (PST)
Subject: Re: tty splice branch (was "Re: Splicing to/from a tty")
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <CAHk-=wiDX9K0aj6mQsQM54yyJTg2fkzME82aSswB2woFGmW81Q@mail.gmail.com>
 <C8NLE0OB4QWG.31VIPNC9SIDPG@oguc>
 <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
 <CAHk-=wiw=+A3Lnru7cvTbEka0QTpt14QBA06C49n+SJ_WQ1VFw@mail.gmail.com>
 <ce1230bd-e310-9b2a-a1ed-1547bd7181e7@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <1005a065-fbe7-ccaa-90a0-6488b8fa66de@kernel.org>
Date:   Thu, 21 Jan 2021 09:58:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ce1230bd-e310-9b2a-a1ed-1547bd7181e7@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 01. 21, 9:50, Jiri Slaby wrote:
> Hm, I would like to review this first. I noticed the changes only 
> because a new branch appeared when I grabbed your tree and the branch 
> has "tty" in its name.

Which is weird as you Cced me. Let me check what is wrong with my e-mail 
setup.

thanks,
-- 
js
