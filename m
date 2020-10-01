Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4FA27FECC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbgJAMMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:12:48 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:49088 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731670AbgJAMMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:12:47 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 08:12:46 EDT
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 7EAB8655;
        Thu,  1 Oct 2020 14:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1601553909; x=1603368310; bh=jzNnZ0a0tZpvXi+43FH2M7TC5gR1DXRl1b9
        fSc6m8v8=; b=SUPvYGYljq0H3iv3GJiMZyUNbQOfa616B8b1JRyX3NfNKcYrrIS
        kQiNF3/m8eUJDSG8cCrNLGdWCBChcm3Fwf/J1R8wahH8gZ8UWJJ/Sao6cZxZu7qQ
        cn9+FBZ0oi2XuNRsNlCvC/JB3nkMJNosSZ6qP7mcTjIiNwIhocwbVO3paWr9Q7P4
        O+RrJUGA58TPGi1cHOfACiiZ5GObR6V55mGBY5QxbT7pCjnvG6H4M+f1pIhaxWGo
        ehzBd/zZmtHaU5l9fzDkFvBM68Q41WJxblY2dBgIE5Ia13JrIPLFNMVaSWSSlsWQ
        T+gzotVPGOyvuClm7HgCSzHvu0hfTfw5eqYewI3+1IF0v283h1BinVMsTWDdipfr
        ahLTZwE+RZ+2/bdPMGo14/ngpWBxnOIsUrRsIf6jd8HKQ4wDjbO50hX6bO3J8MsL
        M7QmAVL9Q0ACh7GThu0YWqFwiZEBF601dKDzCkgU/rW//OiahnKkMgRPADTP+LyJ
        jn00UWxmeScCIwYS3x3BIC8Ikeb2XClNKelW366yOHxbg6mD0YkHGMVybk19eBYc
        TBBTvuixRo9R2DrgLDVoQgpfo/OR+vQ0Ku0jM0rPEyfPAEu0KLOGOn8+e0vKFxQc
        F7fKghsdakLzwWuypZ34yvFK2N435tAy7Yl1LJOOR9j+DMJHjfpBA94s=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E0XL5by57ziI; Thu,  1 Oct 2020 14:05:09 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id A2ACB49A;
        Thu,  1 Oct 2020 14:05:09 +0200 (CEST)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 10BC815E;
        Thu,  1 Oct 2020 14:05:09 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Oct 2020 14:05:07 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 46/52] docs: it_IT: hacking.rst: fix a typo on a markup
In-Reply-To: <741db941bc9e9818c26ba84a8cf119036bc3c4b0.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
 <741db941bc9e9818c26ba84a8cf119036bc3c4b0.1601467849.git.mchehab+huawei@kernel.org>
Message-ID: <dd9081bc0dfb5ed29545fa09e7500f66@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-30 15:25, Mauro Carvalho Chehab wrote:
> There's a missing "`", causing this warning:
> 	./Documentation/translations/it_IT/kernel-hacking/hacking.rst:404:
> WARNING: Unparseable C cross-reference: 'cpu_to_be32p(), che prende un
> puntatore\nad un tipo, e ritorna il valore convertito. L\'altra
> variante per\nla famiglia di conversioni "in-situ", come
> :c:func:`cpu_to_be32s'
> 	Invalid C declaration: Expected end of definition. [error at 14]
> 	  cpu_to_be32p(), che prende un puntatore
> 	ad un tipo, e ritorna il valore convertito. L'altra variante per
> 	la famiglia di conversioni "in-situ", come :c:func:`cpu_to_be32s
> 	  --------------^
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

> ---
>  Documentation/translations/it_IT/kernel-hacking/hacking.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> index 6aab27a8d323..3d30b69f1ec1 100644
> --- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> +++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
> @@ -402,7 +402,7 @@ il valore convertito. Tutte le varianti supportano
> anche il processo inverso:
>  :c:func:`be32_to_cpu()`, eccetera.
> 
>  Queste funzioni hanno principalmente due varianti: la variante per
> -puntatori, come :c:func:`cpu_to_be32p(), che prende un puntatore
> +puntatori, come :c:func:`cpu_to_be32p()`, che prende un puntatore
>  ad un tipo, e ritorna il valore convertito. L'altra variante per
>  la famiglia di conversioni "in-situ", come :c:func:`cpu_to_be32s()`,
>  che convertono il valore puntato da un puntatore, e ritornano void.

-- 
Federico Vaga
http://www.federicovaga.it/
