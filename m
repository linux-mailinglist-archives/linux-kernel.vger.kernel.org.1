Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C31027FECF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbgJAMOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:14:31 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:54652 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731767AbgJAMOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:14:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 9008E1173;
        Thu,  1 Oct 2020 14:04:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1601553893; x=1603368294; bh=WFOjaPFWFwLKOkzrLUcwcJl+MLRDfD7UTAK
        zZgQfLro=; b=F4+ZJeHH9nHc8Zw7Hr5Ftfv6O2qzvm6N9hN/8UFN2of/jzbii35
        ggWgB2BvS8zgplPWe2KOzuC1puOHP7MRalxvlYz5rq9ReP0CuFEMH1knXBeQki0A
        Z85dRleDpYZN3CBrDtTYhrz+PtEcDbdKqs9KU9EtS4hYqo5Z/PMkTfher9IOxQC2
        7uhVyWK3zJMT9k1DORtPwpFfyST7QkTmAvDZGEYOEGlmcFTXAuIVNFFX8KZ2veY2
        lJAowxpV8vF9Kfgd7h3X4nB0v5nqge2hpRM4Crg9wSQ/cfkfmWsqLUi4tuQ8UVGu
        2HM9jUVVFsSARmmRYcXXVFVBTlXE/E2AyOPnWQbbLxeeo3hzCpjDQfvd8/3WaiPL
        ElL+iDBegM6LRzVrVN221MiapJDMy0zZoJGJpGOmVd5GxCsdFM5I83l7kEajx5JR
        YCFsCL38R7howfS1oG5qM86Omq962HOq0O9LjNFhWfdPN4XNleVp+V8jNrU8TRhw
        qYOmRT62LCn9fOBOLWy9pPzDoRNjQ3jHKjHbGxxKUCD0GbmYz9ULLzOp7eRfOdQN
        aV9gSS9vfUleoZy2uvCjVbKa5Alf5A8MrBcg+J9crD7RG2cOU4IUeJuktADB6qW8
        tboYJU/BsFqrzXrSfDRqz+NKsDz/kxnlW/V29VWt9DLsa9zPqxTqSZIY=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id evJ1W7hYVqBA; Thu,  1 Oct 2020 14:04:53 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 7B63D1093;
        Thu,  1 Oct 2020 14:04:53 +0200 (CEST)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 0D0FF2005;
        Thu,  1 Oct 2020 14:04:52 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Oct 2020 14:04:51 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 24/52] docs: it_IT: fix namespace collisions at
 locking.rst
In-Reply-To: <d5931981f4534075a044177811292fb182f7a468.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
 <d5931981f4534075a044177811292fb182f7a468.1601467849.git.mchehab+huawei@kernel.org>
Message-ID: <742872e5458dcad09471bae36464633f@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-30 15:24, Mauro Carvalho Chehab wrote:
> The C domain functions there collide with the English ones,
> due to namespace collision, generating lots of warnings with
> Sphinx 3.x:
> 
> 	./include/linux/mutex.h:121: WARNING: Duplicate C declaration, also
> defined in 'translations/it_IT/kernel-hacking/locking'.
> 	Declaration is 'mutex_init'.
> 	./include/linux/mutex.h:152: WARNING: Duplicate C declaration, also
> defined in 'translations/it_IT/kernel-hacking/locking'.
> 	Declaration is 'mutex_is_locked'.
> 	./include/linux/mutex.h:226: WARNING: Duplicate C declaration, also
> defined in 'translations/it_IT/kernel-hacking/locking'.
> 	Declaration is 'mutex_trylock_recursive'.
> 	./kernel/locking/mutex.c:281: WARNING: Duplicate C declaration, also
> defined in 'translations/it_IT/kernel-hacking/locking'.
> 	Declaration is 'mutex_lock'.
> 	...
> 
> Add a namespace tag there, in order to prevent that.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>


> ---
>  Documentation/translations/it_IT/kernel-hacking/locking.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git
> a/Documentation/translations/it_IT/kernel-hacking/locking.rst
> b/Documentation/translations/it_IT/kernel-hacking/locking.rst
> index 4615df5723fb..bf1acd6204ef 100644
> --- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
> +++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
> @@ -1,5 +1,7 @@
>  .. include:: ../disclaimer-ita.rst
> 
> +.. c:namespace:: it_IT
> +
>  :Original: :ref:`Documentation/kernel-hacking/locking.rst
> <kernel_hacking_lock>`
>  :Translator: Federico Vaga <federico.vaga@vaga.pv.it>

-- 
Federico Vaga
http://www.federicovaga.it/
