Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EB12E6C76
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgL1XTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 18:19:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbgL1XSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 18:18:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78D17207A6;
        Mon, 28 Dec 2020 23:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609197488;
        bh=cVPHpuIudEjc8zGIFUCZFRFCaeipjTtrxj4IKwblofE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DadDNsHQ68t73hWMsNiDvIClRfAxs1Le0bjjw+lZZWueQN0QTzLuPmnMaHsEPAdiK
         Q+VfIUj30eaDv3Nb9n09BGzL5OTghjMk+w2pWHL8S5cwk0vdVqOx7SSn6EW1G/68/X
         YnLaLHYLVAD2ZCOWUl9Y5HzKiLEs1Bw3GuKOCflRUMDdtit1xcK2y4986ZX5hUXjsx
         7TV576wKwnmBRVypkX5DssXn36Irmpn5govYMobjvf5yrBVU5N+4DqLAlWVgylbBH5
         LqZbNS1tPu89x8FKil82IWhzkVaGv2GaCVKglplyOO6NYFfXY0ten0hFu1OfmRy820
         6wgL38L+mM5OQ==
Date:   Tue, 29 Dec 2020 00:18:04 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH] Documentation: doc-guide: fixes to sphinx.rst
Message-ID: <20201229001804.33721e6d@coco.lan>
In-Reply-To: <20201228231212.22448-1-rdunlap@infradead.org>
References: <20201228231212.22448-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 28 Dec 2020 15:12:12 -0800
Randy Dunlap <rdunlap@infradead.org> escreveu:

> Various fixes to sphinx.rst:
> 
> - eliminate a double-space between 2 words
> - grammar/wording
> - punctuation
> - call rows in a table 'rows' instead of 'columns' (or does Sphinx
>   call everything a column?)
> - It seems that "amdfonts" should be "amsfonts". I can't find any
>   amdfonts.
> 
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Regards,
Mauro


> ---
>  Documentation/doc-guide/sphinx.rst |   32 +++++++++++++--------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> --- lnx-511-rc1.orig/Documentation/doc-guide/sphinx.rst
> +++ lnx-511-rc1/Documentation/doc-guide/sphinx.rst
> @@ -48,12 +48,12 @@ or ``virtualenv``, depending on how your
>        those versions, you should run ``pip install 'docutils==0.12'``.
>  
>     #) It is recommended to use the RTD theme for html output. Depending
> -      on the Sphinx version, it should be installed  in separate,
> +      on the Sphinx version, it should be installed separately,
>        with ``pip install sphinx_rtd_theme``.
>  
> -   #) Some ReST pages contain math expressions. Due to the way Sphinx work,
> +   #) Some ReST pages contain math expressions. Due to the way Sphinx works,
>        those expressions are written using LaTeX notation. It needs texlive
> -      installed with amdfonts and amsmath in order to evaluate them.
> +      installed with amsfonts and amsmath in order to evaluate them.
>  
>  In summary, if you want to install Sphinx version 1.7.9, you should do::
>  
> @@ -128,7 +128,7 @@ Sphinx Build
>  ============
>  
>  The usual way to generate the documentation is to run ``make htmldocs`` or
> -``make pdfdocs``. There are also other formats available, see the documentation
> +``make pdfdocs``. There are also other formats available: see the documentation
>  section of ``make help``. The generated documentation is placed in
>  format-specific subdirectories under ``Documentation/output``.
>  
> @@ -303,17 +303,17 @@ and *targets* (e.g. a ref to ``:ref:`las
>          - head col 3
>          - head col 4
>  
> -      * - column 1
> +      * - row 1
>          - field 1.1
>          - field 1.2 with autospan
>  
> -      * - column 2
> +      * - row 2
>          - field 2.1
>          - :rspan:`1` :cspan:`1` field 2.2 - 3.3
>  
>        * .. _`last row`:
>  
> -        - column 3
> +        - row 3
>  
>  Rendered as:
>  
> @@ -325,17 +325,17 @@ Rendered as:
>          - head col 3
>          - head col 4
>  
> -      * - column 1
> +      * - row 1
>          - field 1.1
>          - field 1.2 with autospan
>  
> -      * - column 2
> +      * - row 2
>          - field 2.1
>          - :rspan:`1` :cspan:`1` field 2.2 - 3.3
>  
>        * .. _`last row`:
>  
> -        - column 3
> +        - row 3
>  
>  Cross-referencing
>  -----------------
> @@ -361,7 +361,7 @@ Figures & Images
>  
>  If you want to add an image, you should use the ``kernel-figure`` and
>  ``kernel-image`` directives. E.g. to insert a figure with a scalable
> -image format use SVG (:ref:`svg_image_example`)::
> +image format, use SVG (:ref:`svg_image_example`)::
>  
>      .. kernel-figure::  svg_image.svg
>         :alt:    simple SVG image
> @@ -375,7 +375,7 @@ image format use SVG (:ref:`svg_image_ex
>  
>     SVG image example
>  
> -The kernel figure (and image) directive support **DOT** formatted files, see
> +The kernel figure (and image) directive supports **DOT** formatted files, see
>  
>  * DOT: http://graphviz.org/pdf/dotguide.pdf
>  * Graphviz: http://www.graphviz.org/content/dot-language
> @@ -394,7 +394,7 @@ A simple example (:ref:`hello_dot_file`)
>  
>     DOT's hello world example
>  
> -Embed *render* markups (or languages) like Graphviz's **DOT** is provided by the
> +Embedded *render* markups (or languages) like Graphviz's **DOT** are provided by the
>  ``kernel-render`` directives.::
>  
>    .. kernel-render:: DOT
> @@ -406,7 +406,7 @@ Embed *render* markups (or languages) li
>       }
>  
>  How this will be rendered depends on the installed tools. If Graphviz is
> -installed, you will see an vector image. If not the raw markup is inserted as
> +installed, you will see a vector image. If not, the raw markup is inserted as
>  *literal-block* (:ref:`hello_dot_render`).
>  
>  .. _hello_dot_render:
> @@ -421,8 +421,8 @@ installed, you will see an vector image.
>  
>  The *render* directive has all the options known from the *figure* directive,
>  plus option ``caption``.  If ``caption`` has a value, a *figure* node is
> -inserted. If not, a *image* node is inserted. A ``caption`` is also needed, if
> -you want to refer it (:ref:`hello_svg_render`).
> +inserted. If not, an *image* node is inserted. A ``caption`` is also needed, if
> +you want to refer to it (:ref:`hello_svg_render`).
>  
>  Embedded **SVG**::
>  



Thanks,
Mauro
