Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AF42D1C53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgLGVtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:49:14 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:34424 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgLGVtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:49:14 -0500
Received: by mail-oo1-f68.google.com with SMTP id t63so1002380ooa.1;
        Mon, 07 Dec 2020 13:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y6rotUD5Cj+cOu4ib1zm9pX2uBxofrZ/rn0cCo8FKQg=;
        b=ty8FMyyZknRfYKlMFsRVQgW59dPbJ6nB4JndaP1HUHagODGAW7nPSCY5ivO1tYQGW6
         29G8h/anGz70iqWqHv/gRNU92prnluSuwXqqStWZJsEWBCwpg6d11aGd9pW4tgZLtEVU
         fZ9ZJgB9QDOjcIGdRJcQjNmx11GJIq4oL3nTfSbx028ZKl5LCedbI+NMIIhAZiiQIC0F
         qW1Vqv2IJby1QmbEBJFrdzs5ve7RU8TStKFcCtDbKjXUQ7S3F9zPkUYLtWEqOlWQ1m5D
         T4GEeiNVy/o87PHstCHN+fcdfMwQk5cE87Q6Wz3sqJY0QLU/ibO82YlodA9KRGBqYQiW
         PeiA==
X-Gm-Message-State: AOAM532RL0axAw1+NlzldsnujckoFSo/8ltiuMzzbD5tfHBP3h8DoxUM
        GrL68dbaa0t6H41mCTPE1A==
X-Google-Smtp-Source: ABdhPJxYnT7cshF6Zi8wxXFgBu4YMG41wgnDt8hCnJoZDrb6JW3QdAREx42BPwjF74M4vQiwVauOAg==
X-Received: by 2002:a4a:a785:: with SMTP id l5mr14316996oom.83.1607377712962;
        Mon, 07 Dec 2020 13:48:32 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i25sm185808oto.56.2020.12.07.13.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:48:32 -0800 (PST)
Received: (nullmailer pid 890312 invoked by uid 1000);
        Mon, 07 Dec 2020 21:48:31 -0000
Date:   Mon, 7 Dec 2020 15:48:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: Fix error in 'make dtbs_check' when
 using DT_SCHEMA_FILES
Message-ID: <20201207214831.GA865971@robh.at.kernel.org>
References: <2519b8bde507ca6ccea9765ea197adaaa69a66d5.1605712328.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2519b8bde507ca6ccea9765ea197adaaa69a66d5.1605712328.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 05:20:50PM +0200, Cristian Ciocaltea wrote:
> If DT_SCHEMA_FILES is specified and contains more than one file paths,

If that worked before, it was by chance. :) Yes, it's called '_FILES', 
but more than one was on my todo list.

Anyways, I'll apply it.

> 'make dtbs_check' fails with the following message:
> 
>   $ make dtbs_check DT_SCHEMA_FILES="path/to/schema1.yaml path/to/schema2.yaml"
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   Documentation/devicetree/bindings/Makefile:77: recipe for target 'Documentation/devicetree/bindings/processed-schema.json' failed
>   make[1]: *** [Documentation/devicetree/bindings/processed-schema.json] Error 255
>   make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema.json'
>   Makefile:1364: recipe for target 'dt_binding_check' failed
>   make: *** [dt_binding_check] Error 2
> 
> The error code 255 is returned by 'dt-mk-schema' when invoked as
> 'dt-mk-schema -j -u @<tmp-file>', where '<tmp-file>' is a temporary
> file that is generated to contain a list of SPACE delimited schema
> file paths, as indicated via DT_SCHEMA_FILES.
> 
> However, it seems the file format has been recently changed in
> 'dt-mk-schema', which now expects each schema path to be provided on
> a separate line:
> 
>  $ dt-mk-schema --version
>  2020.12.dev4+g6de1c45
> 
> Therefore, let's change '<tmp-file>' content format from
> 
>  path/to/schema1.yaml path/to/schema2.yaml ... path/to/schemaN.yaml
> 
> to
> 
>  path/to/schema1.yaml
>  path/to/schema2.yaml
>  ...
>  path/to/schemaN.yaml
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  Documentation/devicetree/bindings/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index f50420099a55..643eb873fd51 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -37,7 +37,7 @@ quiet_cmd_chk_bindings = CHKDT   $@
>  quiet_cmd_mk_schema = SCHEMA  $@
>        cmd_mk_schema = f=$$(mktemp) ; \
>                        $(if $(DT_MK_SCHEMA_FLAGS), \
> -                           echo $(real-prereqs), \
> +                           printf '%s\n' $(real-prereqs), \
>                             $(find_cmd)) > $$f ; \
>                        $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
>  		      rm -f $$f
> -- 
> 2.29.2
> 
