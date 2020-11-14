Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B8E2B2C03
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 08:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgKNH6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 02:58:16 -0500
Received: from mx.kolabnow.com ([95.128.36.40]:11504 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgKNH6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 02:58:16 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id DCF73CF9;
        Sat, 14 Nov 2020 08:58:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1605340692; x=1607155093; bh=4a3OEO07K8o1EpHFHeP90Pf3Tbp0+K4SWto
        xxevC6fk=; b=kFyXADHdxfhoesEgcNCYtP+gf4YsKwjJAj9YhSOxpmCtA7Z8jdT
        MM8L4rTBer0q5HFm3gULva8aYFDfO/SqLNgYK8TjMhAtIXKxEpHZjHq12lhymx7Z
        AW2eRj+AeZ9wLkS6pC7y6kyKdNluPhz3J1BEYP6HmD6PNmuVjz1nMtl7dokk7iln
        Ds1iuA5YPNfJErg7W3ioqon7Vy90G8Q/16c7BaLyhno+TeDj+aviDl3tUHkoSJzf
        pEOi4iU9MMorWn+cwxhAXshB/QJdtWibBjIMy/7BI7OQKB0SXPj8MDVWbSb1fiSL
        rjVsxv+07DCBAgkCnOO/HpG9omOhgC9eNFEFwcgMf8HQ+Vu5zAQUSN+GCO1beV7k
        BgwFqWGpiVCm56YnSiB+VBqETRlS+pKDPAvk0FJ/mlmzzWkM2myQG2Q6l9oxansr
        PCoxgQM5nhRvYgk08+eGfqJfC2OqHNetK86i7Y83FVBvEetNVNFs92nsNKP8EovI
        OZOcEXRvOJg1q72K8iKT/rYEBKvGAXbAkOwqrqpYuVllsneoesvJnvfDto2fuFg5
        hyJXQy+Ha1Bni2uRYXKVsPiQViQ09haTNYPJfsg2iKhE9zZ66YA+PagMFu/xyGSL
        ltzx3PGV7+0VP+usaNXGv4SdVy9RxM0AcHRjapKfuykHUekkWW1j3Evg=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T0cmrvUdbUI0; Sat, 14 Nov 2020 08:58:12 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 2B807240;
        Sat, 14 Nov 2020 08:58:11 +0100 (CET)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id A8F8B2370;
        Sat, 14 Nov 2020 08:58:11 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 14 Nov 2020 08:58:09 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc:it_IT: align Italian documentation
In-Reply-To: <20201113145347.01fea824@lwn.net>
References: <20201113133638.7989-1-federico.vaga@vaga.pv.it>
 <20201113145347.01fea824@lwn.net>
Message-ID: <660e3652ed5691217df429bae710da88@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-13 22:53, Jonathan Corbet wrote:
> On Fri, 13 Nov 2020 14:36:38 +0100
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> 
>> Translation for the following patches
>> 
>> commit 905705a8fd43 ("docs: programming-languages: refresh blurb on 
>> clang support")
>> commit 5ff4aa70bf34 ("docs: submitting-patches: use :doc: for 
>> references")
>> commit 030f066f677f ("docs: submitting-patches: describe preserving 
>> review/test tags")
>> commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and 
>> one-element arrays")
>> commit 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for 
>> kernel builds to 4.8")
>> commit 5b5bbb8cc51b ("docs: process: Add an example for creating a 
>> fixes tag")
>> commit 858e6845654d ("docs: dt: convert submitting-patches.txt to ReST 
>> format")
>> commit cca73e4946c4 ("docs: Correct the release date of 5.2 stable")
>> commit c170f2eb9648 ("docs: Document cross-referencing between 
>> documentation pages")
>> commit 7c8b9e3000f8 ("kernel-doc: Update "cross-referencing from rST" 
>> section to use automarkup")
>> commit 27def953b63b ("docs: deprecated.rst: Expand str*cpy() 
>> replacement notes")
>> commit 17dca0502314 ("docs: deprecated.rst: Update 
>> zero-length/one-element arrays section")
>> commit 3519c4d6e08e ("Documentation: add minimum clang/llvm version")
>> commit 0bddd227f3dc ("Documentation: update for gcc 4.9 requirement")
>> commit 9f364b605f34 ("submitting-patches.rst: presume git will be 
>> used")
>> commit 4ebdf7be21d6 ("Documentation/maintainer: rehome sign-off 
>> process")
>> commit 7433ff33e8ba ("Documentation/process: expand plain-text 
>> advice")
>> commit eb45fb2fb16d ("docs: process: Add cross-link to security-bugs")
>> commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column 
>> warning")
>> commit f67281a72b30 ("Documentation: process: step 2: Link to email 
>> list fixed")
>> 
>> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> 
> This doesn't apply to docs-next, not quite sure why.

I did the patch on top of the doc-next of 2 days ago. I will have a 
double check.
I have other patches for new translations (4) between doc-next and this 
patch. I will
try to apply it directly on doc-next.

> Also...what changed with v2?  Please always include that information 
> under
> the "---" line.

A missing '_'. I had a pre-compiled documentation when I did the first 
build and I missed a warning.

> Thanks,
> 
> jon

-- 
Federico Vaga
http://www.federicovaga.it/
