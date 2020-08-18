Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA83247B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 02:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHRAZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 20:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgHRAZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 20:25:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EACC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:25:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so19478303ljc.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pV1nYuRB7bVJsg9CixDWp7JHacy9WOMhAm343ll1bEs=;
        b=EigEpMIw1eW0ZYHfolp7U96j0Ln9bHXqstRtdiTGrfs0FkpKqt7c2QxfHDD6m0PBFb
         dKCe11NgMoLhzZqqXN8ckslD3YjgjNDNcZSTIj/hwcMAE5RMZnBPjbkqJfcVGY+S9yFn
         3qhCvfbyYc0MdnzqKTutlI7Fm6pRQPiluHprQNeWJ7bUeXQnDFHMOfcP58JUq8hSbtuj
         yHya+6lDnLxEeRi+arTXSzXwah9a2C9LTPXYWiwKuNoY8ev075WoceyughaUy8/3o9s5
         OfeVw3d/VCMAsVzSHcK4iYpj7ROByH+Yehfm3posuT1JN/yF7ZQMMerOGpmW1h2Xc3BF
         2qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pV1nYuRB7bVJsg9CixDWp7JHacy9WOMhAm343ll1bEs=;
        b=PtWCF3e+70Grbmy7Nt4GbgVnuKTxHvQY3k4uA4v0UXZfoRg7po5Kz7WD4m7ap9aCpB
         PyM+ZPLTtX3/pRD2y6yPZpqUYZS6/yiLrISk0RyaFSdkTG08k6igkCGgnSNyCi1QnsgJ
         EjJuC9FHj810HfJabH6BMm7xwZ0HqyD3GWQXer63rnlS/rY6008ojYiCSuflQnTmUEQk
         4W6/p+iYJwXtSY23XqNh5FMdn1Gn0Ndzs82HAI0y1bM/Yy2sAFbzrYdzAuY09VBX+mfU
         MRd1b3z+45pZyrCgc2ZV63jMicJ/N4wvI9tuc62hE+He/eTuTTtMFZAzUFOAgFoOZz5I
         eA9g==
X-Gm-Message-State: AOAM532Fs+yNMZAqtEA5JKMWVHCHdy4T2qF2JjvoeZN6VwYXfxTy5OTh
        vEZtSDQ/Fa6BX8oFeoyHPhZGPht7ei0=
X-Google-Smtp-Source: ABdhPJx3z6t+4eaGAHxL0o7X8QmDMmQ6LhVXBY3/awc0hRYJJY/dtW1CebkKtk5ep/T7YOZL7kQCAQ==
X-Received: by 2002:a05:651c:1343:: with SMTP id j3mr7866153ljb.112.1597710330224;
        Mon, 17 Aug 2020 17:25:30 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id v14sm5390756ljk.10.2020.08.17.17.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 17:25:29 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] regulator: push allocation in
 regulator_ena_gpio_request() out of lock
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
 <41fe6a9670335721b48e8f5195038c3d67a3bf92.1597195321.git.mirq-linux@rere.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9ba2952d-9399-2e0f-7beb-7e79b91bbb61@gmail.com>
Date:   Tue, 18 Aug 2020 03:25:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <41fe6a9670335721b48e8f5195038c3d67a3bf92.1597195321.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.08.2020 04:31, Michał Mirosław пишет:
> Move another allocation out of regulator_list_mutex-protected region, as
> reclaim might want to take the same lock.

Is it possible to simply use the GFP_NOWAIT flag in all patches where
there is no real need to reshuffle the code? And then add a small
clarifying comment to the code about why GFP_NOWAIT is used.
