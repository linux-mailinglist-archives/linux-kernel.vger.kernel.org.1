Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4D6298C32
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773952AbgJZLoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:44:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44448 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773945AbgJZLoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:44:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id e20so7659277otj.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 04:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oU+Ykxr1VKBqzXDydfR+/7A87d/l7QXcX2iCzCTvC9E=;
        b=OJHx1rla6V2vsjfdZqJ6uImzYBFipIVG7gv6QbgYi2XTCE5rD43dCSKrxKhTuJ7fuJ
         MaFgrINz7L8quW+PGhuQETin+2yCa1Wut4Asw23ShTYt2rVmM3BjY/sABy5VaqjddZ9z
         A38gNAJytuOfMr26IIwxgage7mspTpp9qF6r4pyMMEQ1J5LlHDifCEpqq+Py6QYdTNrX
         1cgoaaA/CrVrr7v1ZtDwddMQ0WJiJeTeqlhDYzWFjYvkRnxlnqrPcDKC+EQV8yCMh1T9
         V9jjVbxQrgSYbQtUH0Lj7t8l3xjBmeWkzbqK6k//vZsOhdcCySpH2uUZcqmj1vuj/IyH
         /eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oU+Ykxr1VKBqzXDydfR+/7A87d/l7QXcX2iCzCTvC9E=;
        b=sg3aGGCK6EsCrwKWYQKT64T8F/T1oMFhHv9A7wPLjvWE48fIPSxkMwZI1pcaBY/Ysh
         5p25FjuK4O2VJr65yzo1/T/G7XOUn+XgECY8d7ojPETMTmb40220TXfxDt6nea8bOsPH
         NuFb6konY9J8uguvfNomRzwLcVAliCX4ZIns2PmsSflgc+Ag4ZP5WAf0mj7Fha7LXh5b
         GD66FELHyoSvIWRrIgWvuU8C4IGQPvDJXF0tYlZj6IVYrO/4DmbWFJX2wlg0rHaDrRb6
         Yh1m5dD3OG/GxE05gLhaGtBFmMyVrsRK8VjR+BS3oRWO4kY2/K0F/1WEup1gYnukIRgP
         8t1w==
X-Gm-Message-State: AOAM531SEFuRDz9+r/EgOpij0flCMQsGp6oeIAEyWoHNZ/aXMaAw3K/s
        xDjD+pFIwZ7q1B7Bsd6NMOH2zLVJTn9YfyXpva2QOQ==
X-Google-Smtp-Source: ABdhPJyA/xissqWiSyDKQ4Hcx5ErMdPOtkRMKYLYiKWqXVZYKGDyzWvdABv5YSleodIfHEEjb3EKtKpo/9868Z2NWbk=
X-Received: by 2002:a05:6830:1d8:: with SMTP id r24mr13590491ota.283.1603712676298;
 Mon, 26 Oct 2020 04:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR11MB5077E3F06F573C8D4170A73595190@PH0PR11MB5077.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5077E3F06F573C8D4170A73595190@PH0PR11MB5077.namprd11.prod.outlook.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 26 Oct 2020 12:44:25 +0100
Message-ID: <CAHUa44HPHazkiG6TEG7s3Ra3qHi009uQNNADhtYbS+nfAo1_4g@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Set a flag to avoid memory leaks
To:     "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>
Cc:     "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 26, 2020 at 3:22 AM Wang, Xiaolei
<Xiaolei.Wang@windriver.com> wrote:
>
> When an rpc message to release memory is not received, a memory leak will occur, which should be released
>
>
>
> unreferenced object 0xffff00006871b580 (size 128):
>
>   comm "swapper/0", pid 1, jiffies 4294892673 (age 428.192s)
>
>   hex dump (first 32 bytes):
>
>     80 b3 71 68 00 00 ff ff 00 e0 71 a8 00 00 00 00 ..qh......q.....
>
>     00 e0 71 68 00 00 ff ff 00 10 00 00 00 00 00 00 ..qh............
>
>   backtrace:
>
>     [<00000000f0425299>] slab_post_alloc_hook+0x6c/0x338
>
>     [<000000004705f905>] kmem_cache_alloc+0x1d4/0x328
>
>     [<00000000773c66a0>] tee_shm_alloc+0x84/0x268
>
>     [<00000000ca052f98>] optee_handle_rpc+0x144/0x5a0
>
>     [<0000000015a8eebe>] optee_do_call_with_arg+0x14c/0x168
>
>     [<00000000d51ef0fd>] optee_open_session+0x12c/0x200
>
>     [<000000007146f51d>] tee_client_open_session+0x24/0x38
>
>     [<00000000ea2b35e7>] optee_enumerate_devices+0xa0/0x2c0
>
>     [<0000000068088775>] optee_probe+0x560/0x690
>
>     [<00000000ad1d997a>] platform_drv_probe+0x54/0xa8
>
>     [<00000000e11592d4>] really_probe+0x118/0x3e0
>
>     [<00000000dacd3142>] driver_probe_device+0x5c/0xc0
>
>     [<0000000077c13842>] device_driver_attach+0x74/0x80
>
>     [<00000000106ccc62>] __driver_attach+0x8c/0xd8
>
>     [<00000000e120c345>] bus_for_each_dev+0x7c/0xd8
>
>     [<00000000b79335f5>] driver_attach+0x24/0x30
>
>
>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>
> ---
>
> drivers/tee/optee/call.c          | 7 ++++++-
>
> drivers/tee/optee/optee_private.h | 2 +-
>
> drivers/tee/optee/rpc.c           | 4 +++-
>
> 3 files changed, 10 insertions(+), 3 deletions(-)
>
>
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c index 20b6fd7383c5..522c133b9d95 100644
>
> --- a/drivers/tee/optee/call.c
>
> +++ b/drivers/tee/optee/call.c
>
> @@ -129,6 +129,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
>
>                struct optee_rpc_param param = { };
>
>                struct optee_call_ctx call_ctx = { };
>
>                u32 ret;
>
> +             unsigned int flags = 0;
>
>
>
>                 param.a0 = OPTEE_SMC_CALL_WITH_ARG;
>
>                reg_pair_from_64(&param.a1, &param.a2, parg); @@ -153,9 +154,13 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
>
>                                                param.a1 = res.a1;
>
>                                                param.a2 = res.a2;
>
>                                                param.a3 = res.a3;
>
> -                                              optee_handle_rpc(ctx, &param, &call_ctx);
>
> +                                             optee_handle_rpc(ctx, &param, &call_ctx, &flags);
>
>                                } else {
>
>                                                ret = res.a0;
>
> +                                             if (flags != 0x0) {
>
> +                                                             param.a0 = 2;
>
> +                                                             optee_handle_rpc(ctx, &param, &call_ctx, &flags);

How can you know that OP-TEE isn't still using this buffer? Buffers
can be long lived.

Cheers,
Jens

>
> +                                             }
>
>                                                break;
>
>                                }
>
>                }
>
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
>
> index 8b71839a357e..1c1d62e21141 100644
>
> --- a/drivers/tee/optee/optee_private.h
>
> +++ b/drivers/tee/optee/optee_private.h
>
> @@ -127,7 +127,7 @@ struct optee_call_ctx {  };
>
>
>
>  void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
>
> -                                    struct optee_call_ctx *call_ctx);
>
> +                                  struct optee_call_ctx *call_ctx, unsigned int *flags);
>
> void optee_rpc_finalize_call(struct optee_call_ctx *call_ctx);
>
>
>
>  void optee_wait_queue_init(struct optee_wait_queue *wq); diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c index b4ade54d1f28..4e76c87b61f4 100644
>
> --- a/drivers/tee/optee/rpc.c
>
> +++ b/drivers/tee/optee/rpc.c
>
> @@ -396,7 +396,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
>
>   * Result of RPC is written back into @param.
>
>   */
>
> void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
>
> -                                    struct optee_call_ctx *call_ctx)
>
> +                                   struct optee_call_ctx *call_ctx, unsigned int *flags)
>
> {
>
>                struct tee_device *teedev = ctx->teedev;
>
>                struct optee *optee = tee_get_drvdata(teedev); @@ -410,6 +410,7 @@ void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
>
>                                                reg_pair_from_64(&param->a1, &param->a2, pa);
>
>                                                reg_pair_from_64(&param->a4, &param->a5,
>
>                                                                                 (unsigned long)shm);
>
> +                                             *flags = 0x1;
>
>                                } else {
>
>                                                param->a1 = 0;
>
>                                                param->a2 = 0;
>
> @@ -420,6 +421,7 @@ void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
>
>                case OPTEE_SMC_RPC_FUNC_FREE:
>
>                                shm = reg_pair_to_ptr(param->a1, param->a2);
>
>                                tee_shm_free(shm);
>
> +                             *flags = 0x0;
>
>                                break;
>
>                case OPTEE_SMC_RPC_FUNC_FOREIGN_INTR:
>
>                                /*
>
> --
>
> 2.25.1
>
>
